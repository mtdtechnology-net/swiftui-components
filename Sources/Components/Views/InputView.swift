//
//  InputView.swift
//  Life40
//
//  Created by Daniel Mandea on 05.07.2023.
//

import SwiftUI

public struct InputView<Content: View>: View {
    
    
    // MARK: - Internal
    
    public var title: String
    public var color: Color
    public var systemImage: String
    public var inputBackground: Color
    public var inputOverlay: Color
    
    @ViewBuilder
    public var content: Content
    
    // MARK: - Init
    
    @inlinable public init(
        title: String,
        color: Color,
        systemImage: String,
        inputBackground: Color,
        inputOverlay: Color,
        @ViewBuilder content:() -> Content) {
            self.title = title
            self.color = color
            self.systemImage = systemImage
            self.inputBackground = inputBackground
            self.inputOverlay = inputOverlay
            self.content = content()
        }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(alignment:.leading) {
            Text(title)
                .font(.callout)
                .foregroundColor(color)
            HStack{
                Image(systemName: systemImage)
                    .foregroundColor(color)
                content
            }
            .modifier(InputFieldModifier(background: inputBackground, overlay: inputOverlay))
        }
        .padding(.top, 5)
    }
}

#Preview {
    InputView(title: "Email", color: .gray, systemImage: "envelope", inputBackground: .white, inputOverlay: .gray) {
        TextField("Enter your email here", text: .constant(""))
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .foregroundColor(.gray)
    }
    .padding()
}
