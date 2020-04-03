//
//  SquareRepositoryModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol RepositoryModelling {
    var id: Int { get }
    var name: String { get }
    var fullName: String { get }
    var description: String? { get }
    var owner: RepsitoryOwnerModel { get }
}

struct SquareRepositoryModel: RepositoryModelling, Decodable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let owner: RepsitoryOwnerModel
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case description = "description"
        case owner = "owner"
    }
}
