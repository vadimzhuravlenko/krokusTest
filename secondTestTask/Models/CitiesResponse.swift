//
//  CitiesResponse.swift
//  secondTestTask
//
//  Created by Vadim Zhuravlenko on 4.08.22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let idLocale, id: Int
    let name: String
    let lang: Int
    let logo: String
    let lastEditTime: Int
    let visible, cityIsRegional: Bool
    let region: Region

    enum CodingKeys: String, CodingKey {
        case idLocale = "id_locale"
        case id, name, lang, logo
        case lastEditTime = "last_edit_time"
        case visible
        case cityIsRegional = "city_is_regional"
        case region
    }
}

enum Region: String, Codable {
    case brestRegion = "Brest region"
    case gomelRegion = "Gomel region"
    case grodnoRegion = "Grodno region"
    case minskRegion = "Minsk region"
    case mogilevRegion = "Mogilev region"
    case vitebskRegion = "Vitebsk region"
}

typealias Welcome = [WelcomeElement]
