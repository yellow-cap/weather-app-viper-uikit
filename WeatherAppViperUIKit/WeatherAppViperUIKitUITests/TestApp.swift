import XCTest

class TestApp {
    private let app = XCUIApplication()
    var weatherPage: WeatherPage { WeatherPage(app) }

    func start() {
        app.launch()
    }
}