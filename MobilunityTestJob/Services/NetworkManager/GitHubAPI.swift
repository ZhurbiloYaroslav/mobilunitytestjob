//
//  GitHubAPI.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

enum GitHubAPI {
    enum SquareRepos {
        private static let path = "https://api.github.com/orgs/square"
        
        static func getRepositories() -> Endpoint<[SquareRepositoryModel]> {
            return Endpoint(path: path + "/repos")
        }
    }
}
