import XCTest

class WeatherPage_Test: BaseTest {

    func test_weatherPageLayout() {
        app.start()

        XCTAssertTrue(app.weatherPage.waitIsOpened, "Unable to open WeatherPage")

        app.weatherPage.mainLocationLabel.tap()

        XCTAssertTrue(
                app.weatherPage.additionalLocationLabel.waitForExistence(timeout: 0),
                "additionalLocationLabel is missing")

        XCTAssertTrue(
                app.weatherPage.currentWeatherDescriptionLabel.waitForExistence(timeout: 0),
                "currentWeatherDescriptionLabel is missing")

        XCTAssertTrue(
                app.weatherPage.currentTemperatureLabel.waitForExistence(timeout: 0),
                "currentTemperatureLabel is missing")

        XCTAssertTrue(
                app.weatherPage.currentWeatherIcon.waitForExistence(timeout: 0),
                "currentWeatherIcon is missing")

        XCTAssertTrue(
                app.weatherPage.additionalWeatherParamsTable.waitForExistence(timeout: 0),
                "additionalWeatherParamsTable is missing")
    }
}