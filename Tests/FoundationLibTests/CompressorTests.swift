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
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testCompressorAlgorithm() {
        Compressor.Algorithm.lz4.compressionAlgorithm().assert.equal(COMPRESSION_LZ4)
        Compressor.Algorithm.zlib.compressionAlgorithm().assert.equal(COMPRESSION_ZLIB)
        Compressor.Algorithm.lzma.compressionAlgorithm().assert.equal(COMPRESSION_LZMA)
        Compressor.Algorithm.lz4Raw.compressionAlgorithm().assert.equal(COMPRESSION_LZ4_RAW)
        Compressor.Algorithm.lzfse.compressionAlgorithm().assert.equal(COMPRESSION_LZFSE)
    }
    
    func testCompression() {
        do {
            try Array {
                Compressor.Algorithm.lz4
                Compressor.Algorithm.lzfse
                Compressor.Algorithm.lzma
                Compressor.Algorithm.zlib
            }.forEach { algorithm in
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
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
}
