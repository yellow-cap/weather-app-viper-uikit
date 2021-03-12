import XCTest
typealias Element = XCUIElement

extension Element {

    func getStaticText(witId: String) -> Element {
        staticTexts[witId]
    }

    func getImage(withId: String) -> Element {
        images[withId]
    }

    func getTable(withId: String) -> Element {
        tables[withId]
    }

    @discardableResult func waitIsExists(timeout: TimeInterval = 5) -> Bool {
        waitForExistence(timeout: timeout)
    }
}
