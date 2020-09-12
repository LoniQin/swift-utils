//
//  File.swift
//  
//
//  Created by lonnie on 2020/9/12.
//

import Foundation

public protocol Networking {
    
    /// Send request
    /// - Parameters:
    ///   - request: instance that can convert to URLRequest
    ///   - completion: completion handler
    func send<T: ResponseConvertable>(
        _ request: RequestConvertable,
        completion: @escaping (Result<T, Error>)->Void
    ) -> URLSessionTaskProtocol?
    
}
