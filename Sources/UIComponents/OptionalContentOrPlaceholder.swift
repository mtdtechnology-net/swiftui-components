//
//  OptionalContentOrPlaceholder.swift
//  UIComponents
//
//  Created by Daniel Mandea on 02.01.2023.
//

import SwiftUI

public struct OptionalContentOrPlaceholder<Content: View, Placeholder: View, Item: Any>: View  {
    
    // MARK: - @State
    
    @Binding var items: [Item]?
    
    // MARK: - @ViewBuilder
    
    @ViewBuilder var content: Content
    @ViewBuilder var placeholder: Placeholder
    
    // MARK: - Init
    
    public init(items: Binding<[Item]?>,
                @ViewBuilder content: () -> Content,
                @ViewBuilder placeholder: () -> Placeholder) {
        self._items = items
        self.content = content()
        self.placeholder = placeholder()
    }
    
    // MARK: - Body
    
    public var body: some View {
        if items?.isEmpty ?? false {
            placeholder
        } else {
            content
        }
    }
}

// MARK: - PreviewProvider

struct OptionalContentOrPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        OptionalContentOrPlaceholder(items: .constant([true])) {
            Text("Content")
        } placeholder: {
            Text("Placeholder")
        }
    }
}
