//
//  NetworkManager.swift
//  NetworkMockTest
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation


// APIService 에서 사용할 URLSession 의 Mock 객체.
// Test Double 중에 Mock 은 호출에 대해 예상하는 결과를 받을 수 있도록 미리 프로그램 된 오브젝트입니다.

// 우리는 보통 URLSession.shared 이라는 URLSession 객체의 dataTask 함수를 이용해 URLSessionDataTask 객체를 얻고, 이걸 resume 해서 네트워킹 시작함.
// test 하려면 이 URLSession 을 바꿔치기 해야함. MockURLSession 을 만들고 Subclass 할 수도 있지만, dataTask 함수를 override 할 수도 있음. 하지만 애플이 이 메서드 변경하면? mocking 을 위해서 코드 개많이 바꿔야할지도. 선언부 , 호출부 모두.
// 그래서 protocol 정의해서 한번 감싸도록. 그러면 바껴도 내부적으로 그거 호출하게 할 수 있음.
//

enum NetworkError: Error {
    case failToParse
    case invalid
}

final class NetworkManager {

    let session: URLSessionProtocol
    
    // 🕸 URLSession 을 주입 받음. 테스트할 때는 MockURLSession 을 주입
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(for url: String,
                                 dataType: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        let dataTask: URLSessionDataTaskProtocol = session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse,
               200..<400 ~= response.statusCode {
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(NetworkError.failToParse))
                }
            } else {
                completion(.failure(NetworkError.invalid))
            }
        })
        dataTask.resume()
    }
}
