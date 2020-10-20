//
//  Image+Extension.swift
//  School
//
//  Created by Deniz Tutuncu on 10/9/20.
//

import Foundation
import SwiftUI

extension Image {
    func resizedTo(aspetRatio: ContentMode, width: CGFloat, height: CGFloat, alignment: Alignment) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: aspetRatio)
            .frame(width: width, height: height, alignment: alignment)
    }
}
