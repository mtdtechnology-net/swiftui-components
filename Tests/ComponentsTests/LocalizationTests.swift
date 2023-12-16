import XCTest
@testable import Components

final class LocalizationTests: XCTestCase {
    
    // MARK: - Localization Tests
    
    func testGenericErrorTitleLocalization() {
        XCTAssertEqual(L10n.genericErrorTitle, "Error")
    }
    
    func testGenericErrorMessageLocalization() {
        XCTAssertEqual(L10n.genericErrorMessage, "Oops Something went wrong.")
    }
}
