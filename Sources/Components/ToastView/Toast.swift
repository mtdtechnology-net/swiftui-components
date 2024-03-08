//
//  Toast.swift
//
//  Created by Marcel on 08.03.2024.
//

import SwiftUI

public struct Toast: Equatable {
    public let type: ToastStyle
    public let title: String
    public let message: String
    public let duration: Double
    public let backgroundColor: Color
    public let foregroundColor: Color

    public init(
        type: ToastStyle,
        title: String,
        message: String,
        duration: Double = 3.0,
        backgroundColor: Color,
        foregroundColor: Color
    ) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
}
