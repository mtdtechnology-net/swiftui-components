//
//  FullButtonStyle.swift
//  Components
//
//  Created by Daniel Mandea on 03.07.2023.
//

import Foundation
import SwiftUI

public struct FullButtonStyle: ButtonStyle {
    
    // MARK: - Init
    
    public var background: Color
    
    // MARK: - Init
    
    public init(background: Color) {
        self.background = background
    }
    
    // MARK: - Make Body
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration
            .label
            .font(.body)
            .padding([.leading, .trailing], 16)
            .padding([.top, .bottom], 16)
            .background(background)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
