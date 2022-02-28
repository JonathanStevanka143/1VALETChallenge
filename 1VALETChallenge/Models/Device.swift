//
//  Device.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation

// MARK: - DeviceData
struct DeviceData: Decodable {
    let id, type, currency, imageUrl, title, deviceDescription: String
    let price : Int
    let isFavourite : Bool
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case price = "price"
        case currency = "currency"
        case isFavourite = "isFavourite"
        case imageUrl = "imageUrl"
        case title = "title"
        case deviceDescription = "description"
    }
}


