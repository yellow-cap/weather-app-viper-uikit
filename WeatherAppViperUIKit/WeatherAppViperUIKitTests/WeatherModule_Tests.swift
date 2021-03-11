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

    func test_parse_placemark_with_full_data() {
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

    func test_parse_placemark_with_empty_locality() {
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

    func test_parse_placemark_with_just_country() {
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

    func test_parse_placemark_with_no_data() {
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
}
