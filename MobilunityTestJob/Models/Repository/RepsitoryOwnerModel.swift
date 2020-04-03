//
//  RepsitoryOwnerModel.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 03.04.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

protocol RepsitoryOwnerModelling {
    var avatarUrl: URL? { get }
}

struct RepsitoryOwnerModel: RepsitoryOwnerModelling, Decodable {
    var avatarUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      avatarUrl = try container.decodeIfPresent(URL.self, forKey: .avatarUrl)
    }
}
