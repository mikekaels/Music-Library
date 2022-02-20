// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let images = try? newJSONDecoder().decode(Images.self, from: jsonData)

import Foundation

// MARK: - Image
struct Image: Codable {
    let urls: Urls?
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
}

typealias Images = [Image]
