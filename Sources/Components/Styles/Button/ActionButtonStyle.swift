//
//  ActionButtonStyle.swift
//  Components
//
//  Created by Daniel Mandea on 15.07.2023.
//

import Foundation
import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    
    // MARK: - Private
    
    private let color: Color
    
    // MARK: - Init
    
    init(color: Color) {
        self.color = color
    }
    
    // MARK: - ButtonStyle
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .font(.body)
            .background(.white)
            .foregroundColor(color)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 13).stroke(color, lineWidth: 1))
    }
}
