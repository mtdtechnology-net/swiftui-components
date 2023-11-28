//
//  GenericTextField.swift
//
//
//  Created by Marcel on 27.11.2023.
//

import Foundation
import SwiftUI

public enum InputType {
    case normal
    case defaultDigits
    case currencyDigits
    case phonePad
    case emailAddress
    case letters
}

public struct GenericTextField: UIViewRepresentable, Identifiable {
    @Environment(\.redactionReasons) var redactionReasons

    @Binding var inputValue: String
    @Binding var isFirstResponder: Bool

    public var id: UUID = UUID()
    var placeholder: String?
    var padding: CGFloat
    var lengthLimit: Int?
    var inputType: InputType
    var isSecureText: Bool = false
    var textColor: Color
    var icon: String?
    var iconColor: Color?
    var currencyCode: String?
    var autocapitalization: UITextAutocapitalizationType
    var autocorrectionType: UITextAutocorrectionType = .default
    var onEditingChanged: ((Bool) -> Void)
    var textDidChange: ((String) -> Void)?

    // The largest integer we can store is an UInt64 (18,446,744,073,709,551,615). If we exceed that number, we'll be facing some unexpected behaviours.
    public static let numberInputLengthLimit = 15

    public init(text: Binding<Int>,
                lengthLimit: Int? = GenericTextField.numberInputLengthLimit,
                isSecureText: Bool = false,
                textColor: Color,
                icon: String? = nil,
                padding: CGFloat = 0,
                currencyCode: String? = nil,
                isFirstResponder: Binding<Bool>,
                autocapitalization: UITextAutocapitalizationType,
                onEditingChanged: ((Bool) -> Void)? = nil,
                textDidChange: ((String) -> Void)? = nil
    ) {
        self._inputValue = GenericTextField.bindingIntToString(value: text)
        self.lengthLimit = lengthLimit
        self.isSecureText = isSecureText
        self.inputType = currencyCode != nil ? .currencyDigits : .defaultDigits
        self.textColor = textColor
        self.icon = icon
        self.padding = padding
        self.currencyCode = currencyCode
        self._isFirstResponder = isFirstResponder
        self.onEditingChanged = onEditingChanged ?? { _ in }
        self.autocapitalization = autocapitalization
        self.textDidChange = textDidChange
    }

    public init(_ placeholder: String? = "",
                text: Binding<String>,
                lengthLimit: Int? = nil,
                isSecureText: Bool = false,
                inputType: InputType,
                textColor: Color,
                icon: String? = nil,
                padding: CGFloat = 0,
                currencyCode: String? = nil,
                isFirstResponder: Binding<Bool>,
                autocapitalization: UITextAutocapitalizationType = .sentences,
                autocorrectionType: UITextAutocorrectionType = .default,
                onEditingChanged: ((Bool) -> Void)? = nil,
                textDidChange: ((String) -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._inputValue = text
        self.lengthLimit = {
            let isNumberInput = inputType == .defaultDigits || inputType == .currencyDigits
            return lengthLimit == nil && isNumberInput ? GenericTextField.numberInputLengthLimit : lengthLimit
        }()
        self.isSecureText = isSecureText
        self.inputType = inputType
        self.textColor = textColor
        self.icon = icon
        self.padding = padding
        self.currencyCode = currencyCode
        self._isFirstResponder = isFirstResponder
        self.autocapitalization = autocapitalization
        self.autocorrectionType = autocorrectionType
        self.onEditingChanged = onEditingChanged ?? { _ in }
        self.textDidChange = textDidChange
    }

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.placeholder = self.placeholder
        textField.textColor = UIColor(self.textColor)

        // Create an UIImageView for the icon/image
        if let icon {
            let imageView = UIImageView(image: UIImage(systemName: icon))
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = UIColor(iconColor ?? .gray)
            imageView.frame = CGRect(x: 0, y: 7.5, width: 25.0, height: 25.0)
            let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
            imageContainerView.addSubview(imageView)
            textField.leftView = imageContainerView
            textField.leftViewMode = .always
        } else {
            textField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.padding, height: 40))
            textField.leftViewMode = .always
        }

        textField.rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.padding, height: 20))
        textField.rightViewMode = .always
        textField.textAlignment = .left
        textField.autocapitalizationType = self.autocapitalization
        textField.autocorrectionType = self.autocorrectionType
        textField.isSecureTextEntry = self.isSecureText

        if let currencyCode = currencyCode {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            label.text = currencyCode
            label.textColor = UIColor.gray
            label.textAlignment = .right
            label.sizeToFit()
            textField.rightView?.frame.size.width += label.frame.width
            textField.rightView?.addSubview(label)
        }

        switch self.inputType {
        case .letters:
            textField.keyboardType = .asciiCapable
            textField.defaultTextAttributes.updateValue(0.5, forKey: NSAttributedString.Key.kern)
        case .emailAddress:
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
        case .defaultDigits, .currencyDigits:
            textField.keyboardType = .numberPad
        case .phonePad:
            textField.keyboardType = .phonePad
            textField.textContentType = .telephoneNumber
        case .normal:
            textField.keyboardType = .default
        }

        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        if redactionReasons.rawValue != 0 {
            uiView.alpha = 0.5
            uiView.isEnabled = false
        } else {
            uiView.alpha = 1
            uiView.isEnabled = true
        }

        if inputType == .currencyDigits {
            if inputValue.formatWithSpaces() != uiView.text {
                uiView.text = inputValue.formatWithSpaces()
            }
        } else {
            uiView.text = inputValue
        }

        // This makes it able to control UITextField focus both inside & outside the GenericTextField.
        // isFirstResponder should always match the uiView.isFirstResponder
        // Thus the reason for the checks below:
        _ = isFirstResponder ? uiView.becomeFirstResponder() : uiView.resignFirstResponder()
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self, onEditingChanged: onEditingChanged, onTextDidChange: textDidChange, isFirstResponder: $isFirstResponder)
    }

    public final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: GenericTextField
        var onEditingChanged: ((Bool) -> Void)
        var onTextDidChange: ((String) -> Void)?
        var isFirstResponder: Binding<Bool>

        init(_ textField: GenericTextField,
             onEditingChanged: @escaping ((Bool) -> Void),
             onTextDidChange: ((String) -> Void)?,
             isFirstResponder: Binding<Bool>) {
            self.parent = textField
            self.onEditingChanged = onEditingChanged
            self.onTextDidChange = onTextDidChange
            self.isFirstResponder = isFirstResponder
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            guard self.parent.inputType != .currencyDigits  else {
                guard textField.markedTextRange == nil,
                      self.parent.inputValue != textField.text?.withoutSpaces() else { return }
                self.parent.inputValue = (textField.text ?? "").withoutSpaces()
                return
            }

            self.parent.inputValue = textField.text ?? ""
        }

        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let textfieldString: NSString = textField.text as NSString? {
                let completeString = textfieldString.replacingCharacters(in: range, with: string)

                let isWithinLengthLimit = (parent.inputValue.count == parent.lengthLimit && parent.lengthLimit != nil)
                let typedTextIsNotEmpty = (string != "")

                if isWithinLengthLimit && typedTextIsNotEmpty { return false }

                if parent.inputType == .defaultDigits || parent.inputType == .currencyDigits {
                    if string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                        if let textDidChange = onTextDidChange {
                            textDidChange(completeString.withoutSpaces())
                        }
                        return true
                    }
                    return false
                } else if parent.inputType == .phonePad {
                    let allowedChars = CharacterSet(charactersIn: "+0123456789")
                    if string.rangeOfCharacter(from: allowedChars.inverted) == nil {
                        if let textDidChange = onTextDidChange {
                            textDidChange(completeString)
                        }
                        return true
                    }
                } else if parent.inputType == .letters {
                    if string.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil {
                        if let textDidChange = onTextDidChange {
                            textDidChange(completeString)
                        }
                        return true
                    }
                    return false
                } else if parent.inputType == .normal || parent.inputType == .emailAddress {
                    if let textDidChange = onTextDidChange {
                        textDidChange(completeString)
                    }
                    return true
                }
            }
            return false
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            onEditingChanged(true)
            DispatchQueue.main.async {
                let position = textField.endOfDocument
                textField.selectedTextRange = textField.textRange(from: position, to: position)
                self.isFirstResponder.wrappedValue = true
            }
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            onEditingChanged(false)
            DispatchQueue.main.async {
                self.isFirstResponder.wrappedValue = false
            }
        }

    }
}

public extension GenericTextField {
    static func bindingIntToString(value: Binding<Int>) -> Binding<String> {
        return Binding<String>(
            get: { "\(value.wrappedValue)" },
            set: { value.wrappedValue = Int($0) ?? 0 }
        )
    }
}

private extension String {
    func formatWithSpaces() -> String {
        guard !self.isEmpty else { return self }
        let number = NSNumber(value: Double(self.withoutSpaces()) ?? 0.0)
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return formatter.string(from: number) ?? self
    }

    func withoutSpaces() -> String {
        self.replacingOccurrences(of: #"\s"#, with: "", options: .regularExpression)
    }
}
