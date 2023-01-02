//
//  PlaceholderView.swift
//  PlaceholderView
//
//  Created by Daniel Mandea on 27.08.2021.
//

import SwiftUI

public struct PlaceholderView: View {
    
    // MARK: - Internal Variables
    
    public var image: Image
    public var message: String
    
    // MARK: - Init
    
    public init(image: Image, message: String) {
        self.image = image
        self.message = message
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(40)
                        .foregroundColor(.accentColor)
                    Text(message)
                        .font(.body)
                        .foregroundColor(.accentColor)
                }
                .padding()
            }
            Spacer()
        }
    }
}

// MARK: - PreviewProvider

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(image: Image(systemName: "figure.barre"), message: "You have no data for this page!")
    }
}
