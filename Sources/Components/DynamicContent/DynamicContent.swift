//
//  DynamicContent.swift
//  Components
//
//  Created by Daniel Mandea on 02.01.2023.
//

import SwiftUI

public struct DynamicContent<Content: View, Placeholder: View, Item>: View {
    
    // MARK: - Properties
    
    var items: [Item]
    var content: () -> Content
    var placeholder: () -> Placeholder
    
    // MARK: - Init
    
   public init(
        items: [Item],
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.items = items
        self.content = content
        self.placeholder = placeholder
    }
    
    // MARK: - Body
    
    public var body: some View {
        if items.isEmpty {
            placeholder()
        } else {
            content()
        }
    }
}

#Preview {
    DynamicContent(items: ["One", "Two"]) {
        Text("Content")
    } placeholder: {
        PlaceholderView {
            Image(systemName: "figure.barre")
        } message: {
            Text("You have no data for this page!")
        }
    }
    
    DynamicContent(items: []) {
        Text("Content")
    } placeholder: {
        PlaceholderView {
            Image(systemName: "figure.barre")
        } message: {
            Text("You have no data for this page!")
        }
    }
}
