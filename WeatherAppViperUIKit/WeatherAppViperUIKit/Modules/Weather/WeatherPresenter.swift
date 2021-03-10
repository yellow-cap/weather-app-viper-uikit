import Foundation
import CoreLocation
import UIKit

protocol IWeatherPresenter: IPresenter {
    var interaction: IWeatherInteraction? { get set }
    var view: IWeatherView? { get set }
    func viewDidLoad()
    func updateCurrentLocation(placeMark: CLPlacemark)
    func updateWeather(weatherForecast: WeatherForecast)
    func updateWeatherIcon(iconData: Data?)
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
                temp: weatherForecast.current.temp.toStringCelsius(),
                feelsLike: String(weatherForecast.current.feels_like),
                description: weatherForecast.current.weather.last?.description.capitalized ?? ""
        )
    }

    func updateWeatherIcon(iconData: Data?) {
        guard let iconData = iconData, let image = UIImage(data: iconData) else {
            view?.updateWeatherIcon(image: UIImage(systemName: "cloud")!)

            return
        }

        view?.updateWeatherIcon(image: image)
    }
}
