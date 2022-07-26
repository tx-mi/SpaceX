//
//  LaunchModel.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

struct Launch: Codable {
    let success: Bool?
    let name: String
    let date_unix: Int
}
