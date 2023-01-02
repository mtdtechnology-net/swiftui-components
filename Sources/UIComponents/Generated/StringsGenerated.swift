// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Oops Something went wrong.
  public static var genericErrorMessage: String { return L10n.tr("Localizable", "generic_error_message", fallback: "Oops Something went wrong.") }
  /// Localizable.strings
  ///   Created by Daniel Mandea on 02.01.2023.
  ///   String that is part of get started screeen
  public static var genericErrorTitle: String { return L10n.tr("Localizable", "generic_error_title", fallback: "Error") }
  /// Please try again later
  public static var internalErrorMessage: String { return L10n.tr("Localizable", "internal_error_message", fallback: "Please try again later") }
  /// An internal error occured!
  public static var internalErrorTitle: String { return L10n.tr("Localizable", "internal_error_title", fallback: "An internal error occured!") }
  /// Please check your connection and try again
  public static var networkErrorMessage: String { return L10n.tr("Localizable", "network_error_message", fallback: "Please check your connection and try again") }
  /// A networking error occured!
  public static var networkErrorTitle: String { return L10n.tr("Localizable", "network_error_title", fallback: "A networking error occured!") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = TranslationService.lookupTranslation(forKey:inTable:value:)(key, table, value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
