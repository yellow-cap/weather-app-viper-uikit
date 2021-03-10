import Foundation
import CoreLocation

class WeatherViewHelper {
    static func parseLocation(_ placeMark: CLPlacemark) -> (String, String) {
        var mainLocationString = ""
        var additionalLocationString = ""

        if let locality = placeMark.locality, !locality.isEmpty {
            mainLocationString = String(locality)

            additionalLocationString = String(placeMark.administrativeArea ?? "")

            if let country = placeMark.country {
                additionalLocationString += ", \(country)"
            }

        } else {
            mainLocationString = String(placeMark.administrativeArea ?? "")

            if let country = placeMark.country {
                mainLocationString += ", \(country)"
            }
        }

        return (mainLocationString, additionalLocationString)
    }
}
