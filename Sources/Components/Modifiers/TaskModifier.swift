//
//  SwiftUIView.swift
//
//
//  Created by Daniel Mandea on 24.03.2024.
//

import SwiftUI

public struct TaskModifier: ViewModifier {
    
    // MARK: - Private
    
    private let oneTask: @Sendable () async -> Void
    private let priority: TaskPriority
    
    // MARK: - State
    
    @State private var hasAppeared = false
    
    // MARK: - Init
    
    public init(priority: TaskPriority = .userInitiated, _ oneTask: @escaping @Sendable () async -> Void) {
        self.priority = priority
        self.oneTask = oneTask
    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        content
            .task(priority: priority) {
                guard !hasAppeared else { return }
                hasAppeared = true
                await oneTask()
            }
    }
}

extension View {
    public func oneTask(priority: TaskPriority = .userInitiated, _ action: @escaping @Sendable () async -> Void) -> some View{
        modifier(TaskModifier(priority: priority, action))
    }
}
