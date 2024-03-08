//
//  ToastView.swift
//
//  Created by Marcel on 08.03.2024.
//

import SwiftUI

public struct ToastView: View {

    // MARK: - Properties

    let type: ToastStyle
    let title: String
    let message: String
    let backgroundColor: Color
    let foregroundColor: Color
    var onCancelTapped: (() -> Void)

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)

                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundStyle(foregroundColor)
                        .font(.system(size: 14, weight: .semibold))

                    Text(message)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }

                Spacer(minLength: 10)

                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(foregroundColor)
                }
            }
            .padding()
        }
        .background(backgroundColor)
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        ToastView(
            type: .error,
            title: "Error",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
            backgroundColor: .white,
            foregroundColor: .black
        ) {}

        ToastView(
            type: .info,
            title: "Info",
            message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
            backgroundColor: .black,
            foregroundColor: .white
        ) {}
    }
}
