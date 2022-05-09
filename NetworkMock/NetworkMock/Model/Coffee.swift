//
//  Coffee.swift
//  NetworkMock
//
//  Created by 강수진 on 2022/05/06.
//

import Foundation

struct Coffee: Decodable {
    let title: String
    let description: String
    let ingredients: [String]
    let id: Int
}
