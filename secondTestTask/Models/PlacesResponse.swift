//
//  PlacesResponse.swift
//  secondTestTask
//
//  Created by Vadim Zhuravlenko on 9.08.22.
//

import Foundation


struct PlacesElement: Codable {
    let cityID: Int
    let text: String
    let name: String
}

enum CodingKeys: String, CodingKey {
    case cityID = "city_id"
    case name
    case text
}

typealias Places = [PlacesElement]
