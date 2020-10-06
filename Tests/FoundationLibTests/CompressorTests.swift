//
//  CompressorTests.swift
//  
//
//  Created by lonnie on 2020/9/19.
//
import XCTest
import Compression
@testable import FoundationLib
@available(iOS 9.0, OSX 10.11, *)
final class CompressorTests: XCTestCase {
    
    func testCompressorAlgorithm() {
        CompressionAlogrithm.lz4.compressionAlgorithm().assert.equal(COMPRESSION_LZ4)
        CompressionAlogrithm.zlib.compressionAlgorithm().assert.equal(COMPRESSION_ZLIB)
        CompressionAlogrithm.lzma.compressionAlgorithm().assert.equal(COMPRESSION_LZMA)
        CompressionAlogrithm.lzfse.compressionAlgorithm().assert.equal(COMPRESSION_LZFSE)
    }
    
    func testCompresorOperation() {
        Compressor.Operation.encode.compressionStreamOperation().assert.equal(COMPRESSION_STREAM_ENCODE)
        Compressor.Operation.decode.compressionStreamOperation().assert.equal(COMPRESSION_STREAM_DECODE)
    }
    
    func testCompression() throws {
        try CompressionAlogrithm.allCases.forEach { algorithm in
            let postfix = "\(algorithm)"
            let path = dataPath()
            let fileName = "file.log"
            let compression_file_name = path / fileName
            let compressed_file_name = path / fileName + ".\(postfix)"
            let decompressed_file_name = path / fileName + ".2"
            let data = try Data(
                contentsOf: URL(fileURLWithPath: compression_file_name)
            )
            let encoder = try Compressor(
                operation: .encode,
                algorithm: algorithm,
                sourcePath:  compression_file_name,
                destinationPath: compressed_file_name
            )
            try encoder.process()
            let decoder = try Compressor(
                operation: .decode,
                algorithm: algorithm,
                sourcePath:  compressed_file_name,
                destinationPath: decompressed_file_name
            )
            try decoder.process()
            let decodedData = try Data(
                contentsOf: URL(
                    fileURLWithPath: decompressed_file_name
                )
            )
            data.assert.equal(decodedData)
        }
    }
    
}
