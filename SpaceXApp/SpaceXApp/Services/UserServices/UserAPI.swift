//
//  UserAPI.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

enum UserAPI: String {
    case getRockets
    case getLaunches
}

extension UserAPI {
    
    var path: String {
        switch self {
        case .getRockets:
            return "rockets"
        case .getLaunches:
            return "launches"
        }
    }
    
}
