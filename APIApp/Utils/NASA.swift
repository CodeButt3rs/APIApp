//
//  NASA.swift
//  APIApp
//
//  Created by Владислав Лесовой on 12.12.2023.
//

import Foundation
import SwiftData
class Nasa{
    static let photos_url = #"https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?"#
    static let api_key = ProcessInfo.processInfo.environment["NASA_API_KEY"]!
}

// MARK: NASA CAMERA

struct Nasa_Camera_Request: Encodable{
    
    init(sol: Int = 1000, camera: String = "fhaz") {
        self.sol = sol
        self.camera = camera
    }
    var sol: Int = 0
    var camera: String = "pancam"
    let api_key: String = ProcessInfo.processInfo.environment["NASA_API_KEY"]!
}

struct Nasa_Camera_Partial: Codable{
    var name: String
    var full_name: String
}

struct Nasa_Rover: Codable{
    var id: Int
    var name: String
    var landing_date: String
    var launch_date: String
    var status: String
    var max_sol: Int
    var max_date: String
    var total_photos: Int
    var cameras: [Nasa_Camera_Partial]
}

struct Nasa_Camera_Full: Codable{
    var id: Int
    var name: String
    var rover_id: Int
    var full_name: String
}

struct Nasa_Camera_Response: Codable{
    var id: Int
    var sol: Int
    var camera: Nasa_Camera_Full
    var img_src: String
    var earth_date: String
    var rover: Nasa_Rover
}

struct Nasa_Photos_Response: Codable{
    var photos: [Nasa_Camera_Response]
}
@Model
class Nasa_Stored_Photo{
    @Attribute(.externalStorage)
    var image: Data
    var rover_id: Int
    var name: String
    
    init(image: Data, rover_id: Int, name: String) {
        self.image = image
        self.rover_id = rover_id
        self.name = name
    }
}
