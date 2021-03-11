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
        let timeZone = TimeZone(secondsFromGMT: weatherForecast.timezone_offset)

        return [
            (StringResources.additionalWeatherParamFeelsLike, params.feels_like.toStringCelsius()),
            (StringResources.additionalWeatherParamPressure, Double(params.pressure).toStringPressureMmHg()),
            (StringResources.additionalWeatherParamHumidity, params.humidity.toStringPercents()),
            (StringResources.additionalWeatherParamSunrise, params.sunrise
                    .toDate()
                    .getTimeStringForeTimeZone(timeZone: timeZone!)
            ),
            (StringResources.additionalWeatherParamSunset, params.sunset
                    .toDate()
                    .getTimeStringForeTimeZone(timeZone: timeZone!)
            ),
            (StringResources.additionalWeatherParamVisibility, Double(params.visibility).toStringKm()),
            (StringResources.additionalWeatherParamWindSpeed, params.wind_speed.toStringMetersPerSec())
        ]
    }
}
