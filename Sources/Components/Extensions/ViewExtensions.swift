//
//  ViewExtensions.swift
//  Components
//
//  Created by Daniel Mandea on 12.02.2025.
//

import Foundation
import SwiftUI
import LoadingView

extension View {
    /// Use this method in order to show a  certain `DotsActivityView` on top of current view that is blurred out
    /// - Parameters:
    ///   - binding: Defines if the view should be visible or not
    ///   - color: The color of dots
    /// - Returns:  A new  animated `DotsActivityView` `View` presented on top of blurred out `View`
    public func spinner(when binding: Binding<Bool>, color: Color = .accentColor) -> some View {
        show(when: binding) {
            Spinner()
        }
    }

}

