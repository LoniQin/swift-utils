//
//  HttpRequest.swift
//  
//
//  Created by lonnie on 2020/8/16.
//

import Foundation

/// Http request
public struct HttpRequest: RequestConvertable {
    
    public let domain: StringConvertable
    
    public let paths: [StringConvertable]
    
    public let method: HttpMethod
    
    public let query: StringConvertable
    
    public let body: DataConvertable?
    
    public let header: HttpHeaderConvertable
    
    /// Init method
    /// - Parameters:
    ///   - domain: Domain
    ///   - paths: paths
    ///   - method: Http method
    ///   - query: query params
    ///   - body: Body params
    ///   - header: Header params
    public init(domain: StringConvertable,
         paths: [StringConvertable] = [],
         method: HttpMethod = .get,
         query: StringConvertable = "",
         body: DataConvertable? = nil,
         header: HttpHeaderConvertable = [:]) {
        self.domain = domain
        self.paths = paths
        self.method = method
        self.query = query
        self.body = body
        self.header = header
    }
    
    public func toURLRequest() throws -> URLRequest {
        let queryPart = query.toString()
        
        var urlString = (CollectionOfOne(domain) + paths).map { $0.toString() }.joined(separator: "/")
        if !queryPart.isEmpty {
            urlString.append("?\(queryPart)")
        }
        guard let url = URL(string: urlString) else { throw NetworkingError.invalidRequest }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = try body?.toData()
        request.allHTTPHeaderFields = header.toHttpHeader()
        return request
    }
    
}
