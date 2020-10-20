//
//  Makeup.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import Foundation

struct MakeUp: Identifiable, Codable, Hashable {
    var id: Int?
    let brand: String?
    let name: String?
    let price: String?
    let rating: Double?
    let description: String?
    let image_link: String?
}
