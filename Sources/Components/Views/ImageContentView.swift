//
//  ImageContentView.swift
//  Life40
//
//  Created by Daniel Mandea on 05.07.2023.
//

import SwiftUI

public struct ImageContentView : View {
    
    // MARK: - Public
    
    public var title: String
    public var systemImage: String
    
    // MARK: - Init
    
    internal init(title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack {
            Text(title)
                .frame( maxWidth: .infinity)
            Image(systemName: systemImage)
                .padding(.trailing, 5)
        }
    }
}

#Preview {
    ImageContentView(title: "Login", systemImage: "arrow.right")
        .padding()
}
