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

// MARK: - Computed Properties

extension Rocket {
    
    var getPayloadWeights: (String, String) {
        // TODO: Change to UserDefaults.standart.bool(forKey: payloadWeightIsLb)
        let payloadWeightIsLb = true
        
        if payloadWeightIsLb {
            return ("\(payload_weights[0].lb)", "Нагрузка, lb")
        } else {
            return ("\(payload_weights[0].kg)", "Нагрузка, kg")
        }
    }
    
    var getHeight: (String, String) {
        // TODO: Change to UserDefaults.standart.bool(forKey: payloadWeightIsLb)
        let heightIsFt = true
        
        if heightIsFt {
            return ("\(height.feet)", "Высота, ft")
        } else {
            return ("\(height.meters)", "Высота, mt")
        }
    }
    
    var getDiameter: (String, String) {
        // TODO: Change to UserDefaults.standart.bool(forKey: payloadWeightIsLb)
        let diameterIsFt = true
        
        if diameterIsFt {
            return ("\(diameter.feet)", "Диаметр, ft")
        } else {
            return ("\(diameter.meters)", "Диаметр, mt")
        }
    }
    
    var getMass: (String, String) {
        // TODO: Change to UserDefaults.standart.bool(forKey: payloadWeightIsLb)
        let massIsLb = true
        
        if massIsLb {
            return ("\(mass.lb)", "Масса, lb")
        } else {
            return ("\(mass.kg)", "Масса, kg")
        }
    }
    var getFirstFlight: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = "dd MMM, yyyy"
        
        if let date = dateFormatterGet.date(from: first_flight) {
            return dateFormatterOut.string(from: date)
        } else {
            return "-"
        }
        
    }
}
