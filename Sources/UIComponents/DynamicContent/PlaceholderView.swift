//
//  PlaceholderView.swift
//  PlaceholderView
//
//  Created by Daniel Mandea on 27.08.2021.
//

import SwiftUI

public struct PlaceholderView: View {
    
    // MARK: - Internal Variables
    
    @ViewBuilder public var image: Image
    @ViewBuilder public var message: Text
    
    // MARK: - Init
    
    public init(@ViewBuilder image: () -> Image, message: () -> Text) {
        self.image = image()
        self.message = message()
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    image
                    message
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
        if #available(macOS 11.0, *) {
            PlaceholderView {
                Image(systemName: "figure.barre")
            } message: {
                Text("You have no data for this page!")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
