//
//  Compressor.swift
//  
//
//  Created by lonnie on 2020/9/18.
//
#if canImport(Compression)
import Compression
import Foundation

public enum CompressionAlogrithm: UInt32, CaseIterable {
    
    case lz4 = 256

    case zlib = 517
    
    case lzma = 774
    
    case lzfse = 2049
    
    func compressionAlgorithm() -> compression_algorithm {
        return compression_algorithm(rawValue)
    }
    
}

@available(iOS 9.0, OSX 10.11, *)
public struct Compressor {
    
    public enum Operation: UInt32, CaseIterable {
        
        case encode = 0
        
        case decode = 1
        
        func compressionStreamOperation() -> compression_stream_operation {
            return compression_stream_operation(rawValue)
        }
        
    }
    
    public let operation: Operation
    
    public let algorithm: CompressionAlogrithm
    
    public let sourceFileHandle: FileHandle
    
    public let destinationFileHandle: FileHandle
    
    public let progress: (Int64) -> Void
    
    public init(
        operation: Operation,
        algorithm: CompressionAlogrithm,
        sourcePath: String,
        destinationPath: String,
        progress: @escaping (Int64) -> Void = {_ in }
    ) throws {
        self.operation = operation
        self.algorithm = algorithm
        self.sourceFileHandle = try FileHandle(forUpdating: URL(fileURLWithPath: sourcePath))
        try FileManager.default.createFileIfNotExist(destinationPath)
        self.destinationFileHandle = try FileHandle(forWritingTo: URL(fileURLWithPath: destinationPath))
        self.progress = progress
    }
    
    
    public func process() throws {
        
        let bufferSize = 32_768
        let destinationBufferPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer {
            destinationBufferPointer.deallocate()
        }
        
        // Create the compression_stream and throw an error if failed
        var stream = compression_stream()
        
        defer {
            compression_stream_destroy(&stream)
        }
        
        var status = compression_stream_init(
            &stream,
            operation.compressionStreamOperation(),
            algorithm.compressionAlgorithm()
        )
        guard status != COMPRESSION_STATUS_ERROR else {
            throw CompressionError.failToInitCompressionStream
        }
        // Stream setup after compression_stream_init
        // It is indeed important to do it after, since compression_stream_init will zero all fields in stream
        stream.src_size = 0
        stream.dst_ptr = destinationBufferPointer
        stream.dst_size = bufferSize
        
        var sourceData: Data?
        repeat {
            var flags = Int32(0)
            
            // If this iteration has consumed all of the source data,
            // read a new tempData buffer from the input file.
            if stream.src_size == 0 {
                sourceData = sourceFileHandle.readData(ofLength: bufferSize)
                
                stream.src_size = sourceData!.count
                if sourceData!.count < bufferSize {
                    flags = Int32(COMPRESSION_STREAM_FINALIZE.rawValue)
                }
            }
            
            // Perform compression or decompression.
            if let sourceData = sourceData {
                let count = sourceData.count
                
                sourceData.withUnsafeBytes {
                    let baseAddress = $0.bindMemory(to: UInt8.self).baseAddress!
                    
                    stream.src_ptr = baseAddress.advanced(by: count - stream.src_size)
                    status = compression_stream_process(&stream, flags)
                }
            }
            
            switch status {
            case COMPRESSION_STATUS_OK,
                 COMPRESSION_STATUS_END:
                
                // Get the number of bytes put in the destination buffer. This is the difference between
                // stream.dst_size before the call (here bufferSize), and stream.dst_size after the call.
                let count = bufferSize - stream.dst_size
                
                let outputData = Data(bytesNoCopy: destinationBufferPointer,
                                      count: count,
                                      deallocator: .none)
                
                // Write all produced bytes to the output file.
                destinationFileHandle.write(outputData)
                
                // Reset the stream to receive the next batch of output.
                stream.dst_ptr = destinationBufferPointer
                stream.dst_size = bufferSize
                progress(Int64(sourceFileHandle.offsetInFile))
            case COMPRESSION_STATUS_ERROR:
                throw CompressionError.failToCompress
            default:
                break
            }
            
        } while status == COMPRESSION_STATUS_OK
        sourceFileHandle.closeFile()
        destinationFileHandle.closeFile()
    }

}

public extension compression_stream {
    init() {
        self = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1).pointee
    }
}

#endif
