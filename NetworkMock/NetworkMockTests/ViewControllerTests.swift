//
//  ViewControllerTests.swift
//  NetworkMockTests
//
//  Created by 강수진 on 2022/05/06.
//

import XCTest
@testable import NetworkMock

class ViewControllerTests: XCTestCase {
    
    var sut: ViewController!
    
    override func setUpWithError() throws {
        let url = "https://api.sampleapis.com/coffee/hot"
        let data: Data? = JsonLoader.data(fileName: "Coffees")
        let mockURLSession: MockURLSession = MockURLSession.make(url: url,
                                                                 data: data,
                                                                 statusCode: 200)
        let networkManager = NetworkManager(session: mockURLSession)
        sut = ViewController(networkManager: networkManager)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_userDescription_커피를_성공적으로_가져오면_첫번째_커피에_대한_안내문구가_설정된다() {
        // when
        sut.getCoffees()
        
        // then
        let expectation = "Black 커피 나왔습니다"
        XCTAssertEqual(sut.userGuideDescription, expectation)
    }
}
