//
//  ResponsiveButtonStyle.swift
//
//
//  Created by Marcel on 06.11.2023.
//

import SwiftUI

public struct ResponsiveButtonStyle: PrimitiveButtonStyle {
    public var isInteractive: Bool

    public func makeBody(configuration: Configuration) -> some View {
        if !isInteractive {
            configuration.label
        } else {
            PlainButtonStyle().makeBody(configuration: configuration)
        }
    }
}
