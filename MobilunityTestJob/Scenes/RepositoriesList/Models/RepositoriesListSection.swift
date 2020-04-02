//
//  RepositoriesListSection.swift
//  MobilunityTestJob
//
//  Created by Yaroslav Zhurbilo on 30.03.20.
//  Copyright © 2020 Yaroslav Zhurbilo. All rights reserved.
//

import IGListKit

class RepositoriesListSection {
    enum Identifier {
        case empty
        case preload
        case error(title: String, message: String)
        case repository(_ repository: RepositoriesListViewModelProtocol)
        
        var name: NSString {
            switch self {
            case .empty: return "empty"
            case .preload: return "preload"
            case .error(let title, let message): return "error_\(title)_\(message)" as NSString
            case .repository(let model): return "repository_\(model.repositoryId)" as NSString
            }
        }
    }
    
    let id: Identifier
    var items: [ListDiffable] = []
    
    init(id: Identifier) {
        self.id = id
    }
}

extension RepositoriesListSection: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return id.name
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? RepositoriesListSection
            else { return false }
        return object.id.name == id.name
    }
}
