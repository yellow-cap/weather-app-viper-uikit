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
    
    static func prepareTableContent(params: WeatherFull?) -> [(String, String)] {
        guard let params = params else {
            return []
        }

        return [
            ("Feels like", params.feels_like.toStringCelsius()),
            ("Pressure", String(params.pressure)),
            ("Humidity", String(params.humidity)),
            ("Sunrise", String(params.sunrise)),
            ("Sunset", String(params.sunset)),
            ("Visibility", String(params.visibility)),
            ("Wind speed", String(params.wind_speed))
        ]
    }
}
