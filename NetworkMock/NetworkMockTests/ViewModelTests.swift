//
//  ViewModelTests.swift
//  NetworkMockTests
//
//  Created by 강수진 on 2022/05/06.
//

import XCTest
@testable import NetworkMock

class ViewModelTests: XCTestCase {
    
    var sut: SecondViewControllerViewModel!
    var url: String!
    var data: Data!
    
    override func setUpWithError() throws {
        url = "https://api.sampleapis.com/coffee/hot"
        data = JsonLoader.data(fileName: "Coffees")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        url = nil
        data = nil
    }
   
    func test_userDescription_커피를_성공적으로_가져오면_첫번째_커피에_대한_안내문구가_설정된다() {
        // given
        let mockURLSession: MockURLSession = MockURLSession.make(url: url,
                                                                 data: data,
                                                                 statusCode: 200)
        sut = SecondViewControllerViewModel(networkManager: NetworkManager(session: mockURLSession))

        // when
        sut.getCoffees()
        
        // then
        let expectation = "Black 커피 나왔습니다"
        XCTAssertEqual(sut.userGuideDescription.value, expectation)
    }
    
    func test_userDescription_커피를_성공적으로_가져오지_못하면_오류_안내문구가_설정된다() {
        // given
        let mockURLSession: MockURLSession = MockURLSession.make(url: url,
                                                                 data: nil,
                                                                 statusCode: 500)
        sut = SecondViewControllerViewModel(networkManager: NetworkManager(session: mockURLSession))
        
        // when
        sut.getCoffees()
        
        let expectation = "오류가 발생했습니다. 다시 시도해주세요"
        XCTAssertEqual(sut.userGuideDescription.value, expectation)
    }
}

