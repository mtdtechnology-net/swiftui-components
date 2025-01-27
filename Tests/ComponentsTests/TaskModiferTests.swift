//
//  TaskModiferTests.swift
//
//
//  Created by Daniel Mandea on 24.03.2024.
//

import Testing
import SwiftUI
@testable import Components

@MainActor
struct TaskModiferTests {
    @Test  func testExtension() async throws {
        await MainActor.run {
            let task = Text("Hello").oneTask { }
            #expect(task != nil)
        }
    }
}
