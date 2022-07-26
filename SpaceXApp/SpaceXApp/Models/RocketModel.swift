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
    
    // Computed Properties
    var getPayloadWeights: (String, String) {
        // TODO: Change to UserDefaults.standart.bool(forKey: payloadWeightIsLb)
        let payloadWeightIsLb = true
        
        if payloadWeightIsLb {
            return ("\(payload_weights[0].lb)", "Нагрузка, lb")
        } else {
            return ("\(payload_weights[0].kg)", "Нагрузка, kg")
        }
    }
    
    var getFirstFlight: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = ""
        
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = ""
        
        if let date = dateFormatterGet.date(from: first_flight) {
            return dateFormatterOut.string(from: date)
        } else {
            return "-"
        }
        
    }
}
