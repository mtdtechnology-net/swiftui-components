//
//  ToastModifier.swift
//
//
//  Created by Marcel on 08.03.2024.
//

import SwiftUI

struct ToastModifier: ViewModifier {

    // MARK: - Properties

    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?

    // MARK: - Body

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }

    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message,
                    backgroundColor: toast.backgroundColor,
                    foregroundColor: toast.foregroundColor
                ) {
                    dismissToast()
                }
            }
            .transition(.move(edge: .bottom))
        }
    }

    private func showToast() {
        guard let toast = toast else { return }
        if toast.duration > 0 {
            workItem?.cancel()

            let task = DispatchWorkItem {
                dismissToast()
            }

            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }

    private func dismissToast() {
        withAnimation {
            toast = nil
        }

        workItem?.cancel()
        workItem = nil
    }
}

// MARK: - View extension

public extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
