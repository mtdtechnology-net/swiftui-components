//
//  GenericTextField.swift
//
//
//  Created by Marcel on 27.11.2023.
//

import SwiftUI

public struct GenericTextField: View {

    // MARK: - Public Property wrapper

    @State private var isSecureTextEntry = true
    @Binding public var hasError: Bool
    @Binding public var text: String
    @FocusState public var isFocused: Bool

    // MARK: - Public

    /// The title of the text field.
    public let title: String

    /// An optional error description to display when there is an error.
    public var errorDescription: String?

    /// The placeholder text for the text field.
    public let placeholder: String

    /// The name of the icon associated with the text field.
    public let icon: String

    /// A boolean value indicating whether the text field should be secure (e.g., password field).
    public let isSecure: Bool

    /// The color of the border for the text field.
    public let borderColor: Color

    // MARK: - Initialization

    /// Initializes a custom-styled text field view modifier.
    ///
    /// - Parameters:
    ///   - hasError: A binding to a boolean value indicating whether the text field has an error.
    ///   - text: A binding to the text value of the text field.
    ///   - title: The title of the text field.
    ///   - errorDescription: An optional error description to display when there is an error.
    ///   - placeholder: The placeholder text for the text field.
    ///   - icon: The name of the icon associated with the text field.
    ///   - isSecure: A boolean value indicating whether the text field should be secure (e.g., password field).
    ///   - borderColor: The color of the border for the text field.
    public init(
        hasError: Binding<Bool>,
        text: Binding<String>,
        title: String,
        errorDescription: String? = nil,
        placeholder: String,
        icon: String,
        isSecure: Bool,
        borderColor: Color
    ) {
        self._hasError = hasError
        self._text = text
        self.title = title
        self.errorDescription = errorDescription
        self.placeholder = placeholder
        self.icon = icon
        self.isSecure = isSecure
        self.borderColor = borderColor
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.callout)
                .foregroundColor(.gray)
            VStack {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(hasError ? .red : .gray)

                    if isSecureTextEntry && isSecure {
                        SecureField(placeholder, text: $text)
                            .focused($isFocused)
                    } else {
                        TextField(placeholder, text: $text)
                            .focused($isFocused)
                    }

                    if isSecure {
                        Button(action: {
                            // Toggle the visibility of the secure text
                            isSecureTextEntry.toggle()
                        }) {
                            Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .modifier(BorderModifierTextField(
                isFocused: $isFocused,
                hasError: $hasError,
                foregroundColor: borderColor
            ))

            /// Error message
            if let errorDescription {
                Text(errorDescription)
                    .font(.callout)
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    GenericTextField(hasError: .constant(false), text: .constant(""), title: "Title", placeholder: "Placeholder", icon: "plane", isSecure: false, borderColor: .blue)
}
