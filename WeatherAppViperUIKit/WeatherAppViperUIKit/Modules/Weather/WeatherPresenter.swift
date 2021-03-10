import Foundation
import CoreLocation

protocol IWeatherPresenter: IPresenter {
    var interaction: IWeatherInteraction? { get set }
    var view: IWeatherView? { get set }
    func viewDidLoad()
    func updateCurrentLocation(placeMark: CLPlacemark)
    func updateWeather(weatherForecast: WeatherForecast)
}

class WeatherPresenter: IWeatherPresenter {
    var interaction: IWeatherInteraction?
    weak var view: IWeatherView?

    func viewDidLoad() {
        interaction?.initializeServices()
        interaction?.checkLocationServicesPermission()
    }

    func updateCurrentLocation(placeMark: CLPlacemark) {
        view?.updateCurrentLocation(location: WeatherViewHelper.parseLocation(placeMark))
    }

    func updateWeather(weatherForecast: WeatherForecast) {
        print(weatherForecast)
        view?.updateWeather(
                temp: String(weatherForecast.current.temp),
                feelsLike: String(weatherForecast.current.feels_like),
                description: weatherForecast.current.weather.last?.description.capitalized ?? ""
        )
    }
}
