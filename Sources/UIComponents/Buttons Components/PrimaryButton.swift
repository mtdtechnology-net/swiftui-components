//
//  PrimaryButton.swift
//
//
//  Created by Marcel on 06.11.2023.
//

import SwiftUI

public struct PrimaryButton: View {
    let label: String
    let enabled: Bool
    var icon: String?
    var iconAlignment: IconAlignment?
    var isLoading: Bool
    let action: (() -> Void)

    init(label: String,
         enabled: Bool = true,
         icon: String? = nil,
         iconAlignment: IconAlignment? = .left,
         isLoading: Bool = false,
         action: @escaping () -> Void) {
        self.label = label
        self.enabled = enabled
        self.icon = icon
        self.iconAlignment = iconAlignment
        self.isLoading = isLoading
        self.action = action
    }

    public var body: some View {
        Button(action: action, label: {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .shadow(radius: 5)
                .overlay(
                    Group {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            HStack(alignment: .center) {
                                Text(label.localized)
                                if let icon = icon {
                                    Image(systemName: icon)
                                }
                            }
                            .font(.body)
                            .foregroundColor(.white)
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
    enum IconAlignment {
        case left, right
    }
}

public struct ResponsiveButtonStyle: PrimitiveButtonStyle {
    var isInteractive: Bool

    public func makeBody(configuration: Configuration) -> some View {
        if !isInteractive {
            configuration.label
        } else {
            PlainButtonStyle().makeBody(configuration: configuration)
        }
    }
}

#Preview {
    PrimaryButton(label: "Login", icon: "arrow.right", action: {})
}

