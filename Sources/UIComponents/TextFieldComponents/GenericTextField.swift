//
//  GenericTextField.swift
//
//
//  Created by Marcel on 27.11.2023.
//

import SwiftUI

public struct GenericTextField: View {

    // MARK: - Property wrapper

    @State private var isSelected = false
    @Binding public var isSecureTextEntry: Bool
    @Binding public var hasError: Bool
    @Binding public var text: String

    // MARK: - Public

    public let title: String
    public var errorDescription: String?
    public let placeholder: String
    public let icon: String
    public let isSecure: Bool
    public let borderColor: Color

    // MARK: - Init

    public init(isSecureTextEntry: Binding<Bool>, hasError: Binding<Bool>, text: Binding<String>, title: String, errorDescription: String? = nil, placeholder: String, icon: String, isSecure: Bool, borderColor: Color) {
        self._isSecureTextEntry = isSecureTextEntry
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
                        .foregroundColor(hasError ? .red : .primary)

                    if isSecureTextEntry {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }

                    if isSecure {
                        Button(action: {
                            isSecureTextEntry.toggle()
                        }) {
                            Image(systemName: isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.primary)
                        }
                    }
                }

                // Your other content goes here
            }
            .modifier(ModifiedOnboardingTextField(isSelected: $isSelected, hasError: $hasError, foregroundColor: borderColor))

            /// Error message
            if let errorDescription {
                Text(errorDescription)
                    .font(.callout)
                    .foregroundColor(.red)
            }
        }
    }
}

struct ModifiedOnboardingTextField: ViewModifier {

    @Binding var isSelected: Bool
    @Binding var hasError: Bool
    let foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding([.top, .bottom, .trailing], 15)
            .padding([.leading, .trailing], 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(hasError ? Color.red : (isSelected ? .blue : .gray),
                                  lineWidth: hasError ? 2 : (isSelected ? 2 : 1))
            )
            .onTapGesture { self.isSelected = true }
    }
}
