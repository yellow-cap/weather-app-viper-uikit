import Foundation
import XCTest
import CoreLocation
import Intents
import Contacts

class WeatherModule_Tests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_prepare_location_content_with_full_data() {
        // setup
        let initLocality = "Moscow"
        let initAdministrativeArea = "Moscow Oblast"
        let initCountry = "Russia"

        let expectedMainLocationString = "Moscow"
        let expectedAdditionalLocationString = "Moscow Oblast, Russia"

        // action
        let result = WeatherViewHelper.prepareLocationContent(
                locality: initLocality,
                administrativeArea: initAdministrativeArea,
                country: initCountry)

        //assert
        XCTAssertEqual(result.0, expectedMainLocationString, "Incorrect mainLocationString")
        XCTAssertEqual(result.1, expectedAdditionalLocationString, "Incorrect additionalLocationString")
    }

    func test_prepare_location_content_with_empty_locality() {
        // setup
        let initLocality: String? = nil
        let initAdministrativeArea = "Moscow Oblast"
        let initCountry = "Russia"

        let expectedMainLocationString = "Moscow Oblast, Russia"
        let expectedAdditionalLocationString = ""

        // action
        let result = WeatherViewHelper.prepareLocationContent(
                locality: initLocality,
                administrativeArea: initAdministrativeArea,
                country: initCountry)

        //assert
        XCTAssertEqual(result.0, expectedMainLocationString, "Incorrect mainLocationString")
        XCTAssertEqual(result.1, expectedAdditionalLocationString, "Incorrect additionalLocationString")
    }

    func test_prepare_location_content_with_just_country() {
        // setup
        let initLocality: String? = nil
        let initAdministrativeArea: String? = nil
        let initCountry = "Russia"

        let expectedMainLocationString = "Unknown, Russia"
        let expectedAdditionalLocationString = ""

        // action
        let result = WeatherViewHelper.prepareLocationContent(
                locality: initLocality,
                administrativeArea: initAdministrativeArea,
                country: initCountry)

        //assert
        XCTAssertEqual(result.0, expectedMainLocationString, "Incorrect mainLocationString")
        XCTAssertEqual(result.1, expectedAdditionalLocationString, "Incorrect additionalLocationString")
    }

    func test_prepare_location_content_with_no_data() {
        // setup
        let initLocality: String? = nil
        let initAdministrativeArea: String? = nil
        let initCountry: String? = nil

        let expectedMainLocationString = "Unknown"
        let expectedAdditionalLocationString = ""

        // action
        let result = WeatherViewHelper.prepareLocationContent(
                locality: initLocality,
                administrativeArea: initAdministrativeArea,
                country: initCountry)

        //assert
        XCTAssertEqual(result.0, expectedMainLocationString, "Incorrect mainLocationString")
        XCTAssertEqual(result.1, expectedAdditionalLocationString, "Incorrect additionalLocationString")
    }

    func test_prepare_table_content() {
        // setup
        let weatherForecast = WeatherForecast(
                lat: 55.9872,
                lon: 37.2022,
                timezone: "Europe/Moscow",
                timezone_offset: 10800,
                current: WeatherFull(
                        dt: 1615471453,
                        sunrise: 1615435030,
                        sunset: 1615476327,
                        temp: -8.0,
                        feels_like: -13.71,
                        pressure: 1026,
                        humidity: 35,
                        dew_point: -19.48,
                        uvi: 0.2,
                        clouds: 0,
                        visibility: 10000,
                        wind_speed: 3.0,
                        wind_deg: 230,
                        weather: []
                )
        )

        let expectedParamFeelsLike = (StringResources.additionalWeatherParamFeelsLike, "-13°")
        let expectedParamPressure = (StringResources.additionalWeatherParamPressure, "771.43 mm Hg")
        let expectedParamHumidity = (StringResources.additionalWeatherParamHumidity, "35 %")
        let expectedParamSunrise = (StringResources.additionalWeatherParamSunrise, "06:57")
        let expectedParamSunset = (StringResources.additionalWeatherParamSunset, "18:25")
        let expectedParamVisibility = (StringResources.additionalWeatherParamVisibility, "10.0 km")
        let expectedParamWindSpeed = (StringResources.additionalWeatherParamWindSpeed, "3.0 m/s")


        // action
        let result = WeatherViewHelper.prepareTableContent(weatherForecast: weatherForecast)

        // assert
        XCTAssertEqual(result[0].0, expectedParamFeelsLike.0, "Incorrect expectedParamFeelsLike")
        XCTAssertEqual(result[0].1, expectedParamFeelsLike.1, "Incorrect expectedParamFeelsLike")
        XCTAssertEqual(result[1].0, expectedParamPressure.0, "Incorrect expectedParamPressure")
        XCTAssertEqual(result[1].1, expectedParamPressure.1, "Incorrect expectedParamPressure")
        XCTAssertEqual(result[2].0, expectedParamHumidity.0, "Incorrect expectedParamHumidity")
        XCTAssertEqual(result[2].1, expectedParamHumidity.1, "Incorrect expectedParamHumidity")
        XCTAssertEqual(result[3].0, expectedParamSunrise.0, "Incorrect expectedParamSunrise")
        XCTAssertEqual(result[3].1, expectedParamSunrise.1, "Incorrect expectedParamSunrise")
        XCTAssertEqual(result[4].0, expectedParamSunset.0, "Incorrect expectedParamSunset")
        XCTAssertEqual(result[4].1, expectedParamSunset.1, "Incorrect expectedParamSunset")
        XCTAssertEqual(result[5].0, expectedParamVisibility.0, "Incorrect expectedParamVisibility")
        XCTAssertEqual(result[5].1, expectedParamVisibility.1, "Incorrect expectedParamVisibility")
        XCTAssertEqual(result[6].0, expectedParamWindSpeed.0, "Incorrect expectedParamWindSpeed")
        XCTAssertEqual(result[6].1, expectedParamWindSpeed.1, "Incorrect expectedParamWindSpeed")
    }
}
