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
    
    static func prepareTableContent(weatherForecast: WeatherForecast) -> [(String, String)] {
        let params = weatherForecast.current

        return [
            ("Feels like", params.feels_like.toStringCelsius()),
            ("Pressure", Double(params.pressure).toStringPressureMmHg()),
            ("Humidity", params.humidity.toStringPercents()),
            ("Sunrise", params.sunrise
                    .toDate()
                    .getTimeString()
            ),
            ("Sunset", params.sunset
                    .toDate()
                    .getTimeString()
            ),
            ("Visibility", Double(params.visibility).toStringKm()),
            ("Wind speed", params.wind_speed.toStringMetersPerSec())
        ]
    }
}
