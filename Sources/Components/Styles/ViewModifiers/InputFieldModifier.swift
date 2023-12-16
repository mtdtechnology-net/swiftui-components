//
//  InputFieldModifier.swift
//  Components
//
//  Created by Daniel Mandea on 04.07.2023.
//

import SwiftUI

struct InputFieldModifier: ViewModifier {
    
    // MARK: - Init
    
    public var background: Color
    public var overlay: Color
    
    // MARK: - Init
    
    public init(background: Color, overlay: Color) {
        self.background = background
        self.overlay = overlay
    }
    
    // MARK: -
    
    public func body(content: Content) -> some View {
        content
            .font(.body)
            .padding([.top, .bottom, .trailing], 15)
            .padding([.leading, .trailing], 10)
            .background(background)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(overlay, lineWidth: 1))
    }
}
