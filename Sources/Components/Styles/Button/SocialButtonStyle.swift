//
//  SocialButtonStyle.swift
//  Components
//
//  Created by Daniel Mandea on 05.07.2023.
//

import Foundation
import SwiftUI

public struct SocialButtonStyle: ButtonStyle {
    
    // MARK: - Public Variables
    
    public var foreground: Color
    public var overlay: Color
    
    // MARK: - Init
    
    public init(foreground: Color, overlay: Color) {
        self.foreground = foreground
        self.overlay = overlay
    }
    
    // MARK: - Make Body
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .font(.body)
            .frame(width: 70, height: 70)
            .background(.white)
            .foregroundColor(foreground)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(overlay, lineWidth: 1))
    }
}
