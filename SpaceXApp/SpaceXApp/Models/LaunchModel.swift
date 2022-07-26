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
    let date_utc: String
    
    var getDateUTC: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        let dateUTC = String(date_utc.prefix(10))
        if let date = dateFormatterGet.date(from: dateUTC) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "-"
        }
    }
}
