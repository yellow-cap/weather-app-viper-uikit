import Foundation
import CoreLocation

class WeatherViewHelper {
    static func prepareLocationContent(locality: String?, administrativeArea: String?, country: String?) -> (String, String) {
        var mainLocationString = ""
        var additionalLocationString = ""

        if let locality = locality, !locality.isEmpty {
            mainLocationString = String(locality)

            additionalLocationString = administrativeArea ?? StringResources.locationDefaultString

            if let country = country, !country.isEmpty {
                additionalLocationString += ", \(country)"
            }


        } else {
            mainLocationString = administrativeArea ?? StringResources.locationDefaultString

            if let country = country, !country.isEmpty {
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
