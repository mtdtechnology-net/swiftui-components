//
//  CardModifier.swift
//  Components
//
//  Created by Daniel Mandea on 22.10.2023.
//

import Foundation
import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}
