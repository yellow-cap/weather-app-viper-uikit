import CoreLocation

protocol IWeatherService {
    func getWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast
}

class WeatherService: IWeatherService {
    private let fetcher: IWeatherForecastFetcher

    init(weatherForecastFetcher: IWeatherForecastFetcher ){
        fetcher = weatherForecastFetcher
    }

    func getWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast {
        try fetcher.fetchWeatherForecastForLocation(location: location)
    }
}