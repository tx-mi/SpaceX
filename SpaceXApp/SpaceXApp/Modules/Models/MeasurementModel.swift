//
//  MeasurementModel.swift
//  SpaceXApp
//
//  Created by Ramazan Abdulaev on 23.07.2022.
//

import Foundation

struct Measurement: Codable {
    let meters: Double
    let feet: Double
}

struct Mass: Codable {
    let kg: Int
    let lb: Int
}

struct Stage: Codable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Double?
}
