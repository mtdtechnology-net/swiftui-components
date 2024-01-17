//
//  PrimaryButton.swift
//
//
//  Created by Marcel on 06.11.2023.
//

import SwiftUI

public struct PrimaryButton: View {
    public let label: String
    public let enabled: Bool
    public let foregroundColor: Color
    public let textColor: Color
    public var icon: String?
    public var iconAlignment: IconAlignment?
    public var isLoading: Bool
    public let height: CGFloat
    public let shadowRadius: CGFloat
    public let action: (() -> Void)

    public init(label: String,
                enabled: Bool = true,
                icon: String? = nil,
                foregroundColor: Color,
                textColor: Color,
                iconAlignment: IconAlignment? = .left,
                isLoading: Bool = false,
                height: CGFloat = 44,
                shadowRadius: CGFloat = 5,
                action: @escaping () -> Void) {
        self.label = label
        self.enabled = enabled
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.textColor = textColor
        self.iconAlignment = iconAlignment
        self.isLoading = isLoading
        self.height = height
        self.shadowRadius = shadowRadius
        self.action = action
    }

    public var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .shadow(radius: shadowRadius)
                .overlay(
                    Group {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            HStack(alignment: .center) {
                                Text(label)
                                if let icon = icon {
                                    Image(systemName: icon)
                                }
                            }
                            .font(.body)
                            .foregroundStyle(textColor)
                            .environment(\.layoutDirection, iconAlignment == .left ? .leftToRight : .rightToLeft)
                        }
                    }
                )
        })
        .opacity(!enabled || isLoading ? 0.5 : 1)
        .buttonStyle(ResponsiveButtonStyle(isInteractive: enabled && !isLoading))
    }
}

extension PrimaryButton {
    public enum IconAlignment {
        case left, right
    }
}

#Preview {
    PrimaryButton(label: "Login", icon: "arrow.right", foregroundColor: .accentColor, textColor: .black, action: {})
}

