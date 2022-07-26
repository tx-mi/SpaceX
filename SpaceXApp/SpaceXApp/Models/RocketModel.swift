//
//  RocketsModel.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

struct Rocket: Codable {
    let height: Measurement
    let diameter: Measurement
    let mass: Mass
    let first_stage: Stage
    let second_stage: Stage
    let payload_weights: [Mass]
    let flickr_images: [String]
    let name: String
    let cost_per_launch: Int
    let first_flight: String
    let country: String
}
