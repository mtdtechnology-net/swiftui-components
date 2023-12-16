//
//  AlertViewExtension.swift
//  Components
//
//  Created by Daniel Mandea on 02.01.2023.
//

import SwiftUI

extension View {
    public func errorAlert(error: Binding<InterfaceError?>, dismissButton: Alert.Button? = nil) -> some View {
        alert(item: error) {
            Alert(
                title: Text($0.errorDescription ?? L10n.genericErrorTitle),
                message: Text($0.recoverySuggestion ?? L10n.genericErrorMessage),
                dismissButton: dismissButton
            )
        }
    }
}
