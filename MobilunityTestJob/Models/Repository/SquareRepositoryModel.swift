//
//  SquareRepositoryModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol SquareRepositoryModelProtocol {
    var id: Int { get }
    var name: String { get }
    var description: String? { get }
}

struct SquareRepositoryModel: SquareRepositoryModelProtocol, Decodable {
    let id: Int
    let name: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
    }
}
