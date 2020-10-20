//
//  MakeupViewModel.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import Foundation

struct MakeupViewModel: Identifiable {
    
    let makeup: MakeUp
    
    var id: Int {
        return self.makeup.id ?? 0
    }
    
    var brand: String {
        return self.makeup.brand?.uppercased() ?? "No brand Provided"
    }
    
    var name: String {
        return self.makeup.name?.uppercased() ?? "No Name Provided"
    }
    
    var price: String {
        return "$\(self.makeup.price ?? "NO Price Provided")"
    }
    
    var rating: String {
        return "\(String(describing: self.makeup.rating))"
    }
    
    var description: String {
        return self.makeup.description ?? "No Description Provided"
    }
    
    var imageLink: String {
        return self.makeup.image_link ?? "No Image_Link Provided"
    }
}
