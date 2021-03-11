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
    func onGeneralError()
    func onPermissionsNotGranted()
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
        let additionalWeatherParams = WeatherViewHelper.prepareTableContent(weatherForecast: weatherForecast)

        view?.updateWeather(
                temp: weatherForecast.current.temp.toStringCelsius(),
                description: weatherForecast.current.weather.last?.description.capitalized ?? "",
                additionalWeatherParams: additionalWeatherParams
        )
    }

    func updateWeatherIcon(iconData: Data?) {
        guard let iconData = iconData, let image = UIImage(data: iconData) else {
            view?.updateWeatherIcon(image: UIImage(systemName: "cloud")!)

            return
        }

        view?.updateWeatherIcon(image: image)
    }

    func onGeneralError() {
        view?.showAlert(title: "Oops...", message: "Seems some of the services are unavailable now.")
    }

    func onPermissionsNotGranted() {
        view?.showAlert(title: "Location permissions denied", message: "Please check your location permission for the application in device Settings")
    }
}
