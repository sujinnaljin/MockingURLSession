//
//  NetworkManagerTests.swift
//  NetworkMockTest
//
//  Created by 강수진 on 2022/05/06.
//

import XCTest
@testable import NetworkMock

class NetworkManagerTests: XCTestCase {
    
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "https://api.sampleapis.com/coffee/hot"
        data = JsonLoader.data(fileName: "Coffees")
    }
    
    override func tearDownWithError() throws {
        url = nil
        data = nil
    }
    
    func test_fetchData_Data가_있고_statusCode가_200일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        
        // when
        var result: [Coffee]?
        sut.fetchData(for: url,
                      dataType: [Coffee].self) { response in
            if case let .success(coffees) = response {
                result = coffees
            }
        }
        
        // then
        let expectation: [Coffee]? = JsonLoader.load(type: [Coffee].self, fileName: "Coffees")
        XCTAssertEqual(result?.count, expectation?.count)
        XCTAssertEqual(result?.first?.title, expectation?.first?.title)
    }
    
    func test_fetchData_Data에_대한_잘못된_dataType을_넘겼을때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: data,
                                                 statusCode: 200)
        let sut = NetworkManager(session: mockURLSession)
        
        
        // when
        var result: NetworkError?
        sut.fetchData(for: url,
                      dataType: Coffee.self) { response in
            if case let .failure(error) = response {
                result = error as? NetworkError
            }
        }
        
        // then
        let expectation: NetworkError = NetworkError.failToParse
        XCTAssertEqual(result, expectation)
    }
    
    func test_fetchData_Data가_없고_statusCode가_500일때() {
        // given
        let mockURLSession = MockURLSession.make(url: url,
                                                 data: nil,
                                                 statusCode: 500)
        let sut = NetworkManager(session: mockURLSession)
        
        // when
        var result: Error?
        sut.fetchData(for: url,
                      dataType: [Coffee].self) { response in
            if case let .failure(error) = response {
                result = error
            }
        }
        
        // then
        XCTAssertNotNil(result)
    }
}
