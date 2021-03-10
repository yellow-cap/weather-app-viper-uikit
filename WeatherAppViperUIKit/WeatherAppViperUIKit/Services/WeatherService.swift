import CoreLocation
import UIKit

protocol IWeatherService {
    func getWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast
    func getCurrentWeatherIcon(iconCode: String) throws -> Data?
}

class WeatherService: IWeatherService {
    private let fetcher: IWeatherForecastFetcher

    init(weatherForecastFetcher: IWeatherForecastFetcher ){
        fetcher = weatherForecastFetcher
    }

    func getWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast {
        try fetcher.fetchWeatherForecastForLocation(location: location)
    }

    func getCurrentWeatherIcon(iconCode: String) throws -> Data? {
        try fetcher.fetchCurrentWeatherIcon(iconCode: iconCode)
    }
}