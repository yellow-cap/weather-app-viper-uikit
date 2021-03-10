import Foundation
import CoreLocation

protocol IWeatherForecastFetcher {
    func fetchWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast
    func fetchCurrentWeatherIcon(iconCode: String) throws -> Data?
}

class WeatherForecastFetcher: IWeatherForecastFetcher {
    private let apiFetcher: IApiFetcher
    private let decoder: JSONDecoder

    init(
            apiFetcher: IApiFetcher,
            decoder: JSONDecoder = .init()
    ) {
        self.apiFetcher = apiFetcher
        self.decoder = decoder
    }

    func fetchWeatherForecastForLocation(location: CLLocation) throws -> WeatherForecast {
        let path = ApiUrlBuilder.getCurrentLocationForecastUrl()

        let result = apiFetcher.request(
                type: ApiRequestType.get,
                path: path,
                headers: [:],
                queryParams: [
                    "lat": "\(location.coordinate.latitude)",
                    "lon": "\(location.coordinate.longitude)",
                    "units": "metric",
                    "appid": ApiConstants.openWeatherApiKey]
        )

        switch result {
        case let .success(data):
            do {
                return try self.decoder.decode(WeatherForecast.self, from: data!)
            } catch {
                throw ApiError(message: "WeatherForecastFetcher: Couldn't parse response data")
            }
        case let .failure(error):
            throw error
        }
    }

    func fetchCurrentWeatherIcon(iconCode: String) throws -> Data? {
        let path = ApiUrlBuilder.getCurrentWeatherIcon(iconCode: iconCode)

        let result = apiFetcher.request(
                type: ApiRequestType.get,
                path: path,
                headers: [:],
                queryParams: [:]
        )

        switch result {
        case let .success(data):
            return data
        case let .failure(error):
            throw error
        }
    }
}
