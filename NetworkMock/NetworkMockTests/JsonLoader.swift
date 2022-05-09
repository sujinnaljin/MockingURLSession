//
//  JsonLoader.swift
//  NetworkMockTests
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation

private enum JsonLoaderError: Error {
    case unknownFile
    case dataConvertFail
    case notJsonData
    case decodeFail
}

final class JsonLoader {
    static func load<T: Decodable>(type: T.Type, fileName: String) -> T? {
        do {
            let fileURL = try fileURL(of: fileName)
            let data = try fileData(of: fileURL)
            try checkIsJsonData(of: data)
            let decodeData = try decode(of: data, to: type)
            return decodeData
        } catch {
            loggingError(of: error)
            return nil
        }
    }
    
    static func data(fileName: String) -> Data? {
        do {
            let fileURL = try fileURL(of: fileName)
            let data = try fileData(of: fileURL)
            return data
        } catch {
            loggingError(of: error)
            return nil
        }
    }
    
    private static func fileURL(of fileName: String) throws -> URL {
        let testBundle = Bundle(for: self)
        let filePath = testBundle.path(forResource: fileName, ofType: "json")
        guard let filePath = filePath else {
            throw JsonLoaderError.unknownFile
        }
        let fileURL = URL(fileURLWithPath: filePath)
        return fileURL
    }
    
    private static func fileData(of fileURL: URL) throws -> Data {
        guard let data = try? Data(contentsOf: fileURL) else {
            throw JsonLoaderError.dataConvertFail
        }
        return data
    }
    
    private static func checkIsJsonData(of data: Data) throws {
        guard let _ = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            throw JsonLoaderError.notJsonData
        }
    }
    
    private static func decode<T: Decodable>(of data: Data, to type: T.Type) throws -> T {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw JsonLoaderError.decodeFail
        }
        return decodedData
    }
    
    private static func loggingError(of error: Error) {
        switch error {
        case JsonLoaderError.unknownFile:
            print("😵 file 을 찾을 수 없어요")
        case JsonLoaderError.dataConvertFail:
            print("😵 file 에 있는 내용을 data 로 변환할 수 없어요")
        case JsonLoaderError.notJsonData:
            print("😵 file data 가 json 형식이 아니예요. 주석이 있다면 삭제해주세요")
        case JsonLoaderError.decodeFail:
            print("😵 json 디코딩이 안돼요. type 을 확인해주세요")
        default:
            print("😵 기타 에러 \(error.localizedDescription)")
        }
    }
}
