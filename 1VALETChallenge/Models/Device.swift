//
//  Device.swift
//  1VALETChallenge
//
//  Created by Mac User on 2022-02-28.
//

import Foundation

// MARK: - DeviceData
struct DeviceData: Codable {
    let id, title, os, size, imageUrl, deviceDescription: String
    let isFavourite : Bool
    let status : availability
    
    enum availability: String, Codable {
        case available = "Available"
        case notAvailable = "Not Available"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case os = "os"
        case status = "status"
        case size = "size"
        case isFavourite = "isFavourite"
        case imageUrl = "imageUrl"
        case title = "title"
        case deviceDescription = "description"
    }
}


