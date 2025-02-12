//
//  SpinnerView.swift
//  Components
//
//  Created by Daniel Mandea on 12.02.2025.
//

import SwiftUI

public struct SpinnerView: View {
    
    // MARK: - Public Variabels
    
    public var color: Color
    
    // MARK: - Init
    
    public init(color: Color = .white) {
        self.color = color
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                 .progressViewStyle(CircularProgressViewStyle())
                 .tint(color)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    SpinnerView()
}
