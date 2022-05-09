//
//  URLSessionProtocol.swift
//  NetworkMockTest
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
