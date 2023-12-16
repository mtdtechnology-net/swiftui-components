//
//  PlaceholderView.swift
//  Components
//
//  Created by Daniel Mandea on 27.08.2021.
//

import SwiftUI

public struct PlaceholderView<Top: View, Bottom: View>: View {
    
    // MARK: - Internal Variables
    
    @ViewBuilder public var image: Top
    @ViewBuilder public var message: Bottom
    
    // MARK: - Init
    
    public init(@ViewBuilder image: () -> Top, message: () -> Bottom) {
        self.image = image()
        self.message = message()
    }
    
    // MARK: - Body
    
    public var body: some View {
        HStack {
            Spacer()
            VStack {
                image
                message
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
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
            } message: {
                Text("You have no data for this page!")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
