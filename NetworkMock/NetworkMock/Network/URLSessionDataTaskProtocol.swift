//
//  URLSessionDataTaskProtocol.swift
//  NetworkMock
//
//  Created by 강수진 on 2022/05/09.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
