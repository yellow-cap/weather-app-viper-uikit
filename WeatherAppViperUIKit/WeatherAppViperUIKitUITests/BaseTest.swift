import XCTest

class BaseTest: XCTestCase {
    lazy var app = TestApp()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        addUIInterruptionMonitor(withDescription: "Location permission alert",
                handler: { element -> Bool in
                    let allowOnceButton = element.buttons["Allow Once"].firstMatch

                    if element.elementType == .alert && allowOnceButton.exists {
                        allowOnceButton.tap()

                        return true
                    } else {
                        return false
                    }
                }
        )
    }

    override func tearDown() {
        super.tearDown()
    }
}