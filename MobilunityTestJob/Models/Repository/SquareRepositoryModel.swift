//
//  SquareRepositoryModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

struct SquareRepositoryModel: Decodable {
    let name: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
    }
}
