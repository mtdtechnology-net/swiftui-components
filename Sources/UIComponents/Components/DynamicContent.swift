//
//  DynamicContent.swift
//
//
//  Created by Daniel Mandea on 21.09.2023.
//

import SwiftUI

public struct DynamicContent<Content: View, Item: Any>: View  {
    
    
    // MARK: - @State
    
    var items: [Item]
    var placeholderTitle: String
    var placeholderImage: Image
    
    // MARK: - @ViewBuilder
    
    @ViewBuilder var content: Content
    
    // MARK: - Init
    
    public init(items: [Item],
         _ placeholderTitle: String,
         _ placeholderImage: Image,
         @ViewBuilder content: () -> Content) {
        self.items = items
        self.placeholderTitle = placeholderTitle
        self.placeholderImage = placeholderImage
        self.content = content()
    }
    
    // MARK: - Body
    
    public var body: some View {
        ContentOrPlaceholder(items: items) {
            content
        } placeholder: {
            PlaceholderView(
                image: placeholderImage,
                message: placeholderTitle
            )
        }
    }
}

#Preview {
    DynamicContent(items: ["A", "B"],  "No items yet", Image(systemName: "figure.barre")) {
        Text("The actual content")
    }
}
