//
//  Item.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import Foundation
import SwiftData
@Model
final class Photo {
    var timestamp: Date
    var response: Nasa_Stored_Photo
    
    init(timestamp: Date, response: Nasa_Stored_Photo) {
        self.timestamp = timestamp
        self.response = response
    }
}
