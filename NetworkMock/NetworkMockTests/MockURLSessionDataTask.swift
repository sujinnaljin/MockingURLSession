//
//  MockURLSessionDataTask.swift
//  NetworkMockTest
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation
@testable import NetworkMock

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private let resumeHandler: () -> Void
    
    init(resumeHandler: @escaping () -> Void) {
        self.resumeHandler = resumeHandler
    }
    
    // resume 해도 실제 네트워크 요청들이 일어나면 안됨. 그냥 단순히 completionHandler 호출 용
    func resume() {
        resumeHandler()
    }
}
