//
//  DynamicContent.swift
//  UIComponents
//
//  Created by Daniel Mandea on 02.01.2023.
//

import SwiftUI

public struct DynamicContent<Content: View, Placeholder: View, Item: Any>: View  {
    
    // MARK: - @State
    
    public var items: [Item]
    
    // MARK: - @ViewBuilder
    
    @ViewBuilder public var content: Content
    @ViewBuilder public var placeholder: Placeholder
    
    // MARK: - Init
    
    @inlinable public init(items: [Item],
                @ViewBuilder content: () -> Content,
                @ViewBuilder placeholder: () -> Placeholder) {
        self.items = items
        self.content = content()
        self.placeholder = placeholder()
    }
    
    // MARK: - Body
    
    public var body: some View {
        if items.isEmpty {
            placeholder
        } else {
            content
        }
    }
}

// MARK: - PreviewProvider

struct ContentOrPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        DynamicContent(items: ["One", "Two"]) {
            Text("Content")
        } placeholder: {
            Text("Placeholder")
        }
    }
}
