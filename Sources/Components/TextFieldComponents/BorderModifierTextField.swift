//
//  BorderModifierTextField.swift
//
//
//  Created by Marcel on 20.12.2023.
//

import SwiftUI

public struct BorderModifierTextField: ViewModifier {

    // MARK: - Property wrappers

    @FocusState.Binding public var isFocused: Bool
    @Binding public var hasError: Bool

    // MARK: - Properties

    public let foregroundColor: Color
    public var cornerRadius: CGFloat
    public var paddingHorizontal: CGFloat
    public var paddingVertical: CGFloat
    public var backgroundColor: Color

    // MARK: - Initializer

    /// Initializes a `BorderModifierTextField` view modifier.
    /// - Parameters:
    ///   - isFocused: A binding to a boolean value indicating whether the text field is currently focused.
    ///   - hasError: A binding to a boolean value indicating whether the text field has an error.
    ///   - foregroundColor: Color for the border
    ///   - backgroundColor: Fill color behind the border. Defaults to `.clear`.
    public init(
        isFocused: FocusState<Bool>.Binding,
        hasError: Binding<Bool>,
        foregroundColor: Color,
        cornerRadius: CGFloat = 10,
        paddingHorizontal: CGFloat = 10,
        paddingVertical: CGFloat = 15,
        backgroundColor: Color = .clear
    ) {
        self._isFocused = isFocused
        self._hasError = hasError
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.paddingHorizontal = paddingHorizontal
        self.paddingVertical = paddingVertical
        self.backgroundColor = backgroundColor
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .font(.body)
            .padding([.top, .bottom, .trailing], paddingVertical)
            .padding([.leading, .trailing], paddingHorizontal)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(hasError ? Color.red : (isFocused ? foregroundColor : .gray),
                                          lineWidth: hasError ? 2 : (isFocused ? 2 : 1))
                    )
            )
    }
}
