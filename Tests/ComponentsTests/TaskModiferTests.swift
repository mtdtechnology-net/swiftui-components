//
//  TaskModiferTests.swift
//
//
//  Created by Daniel Mandea on 24.03.2024.
//

import XCTest
import SwiftUI
@testable import Components

final class TaskModiferTests: XCTestCase {
    
    func testInit() throws {
        XCTAssertNotNil(TaskModifier{})
    }
    
    func testExtension() {
        XCTAssertNotNil(Text("Hello")
            .oneTask { } as? ModifiedContent<Text, TaskModifier>
        )
    }
}
