import Foundation
import CoreLocation

protocol IWeatherPresenter: IPresenter {
    var interaction: IWeatherInteraction? { get set }
    var view: IWeatherView? { get set }
    func viewDidLoad()
    func updateCurrentLocation(placeMark: CLPlacemark)
}

class WeatherPresenter: IWeatherPresenter {
    var interaction: IWeatherInteraction?
    weak var view: IWeatherView?

    func viewDidLoad() {
        interaction?.initializeServices()
        interaction?.checkLocationServicesPermission()
    }

    func updateCurrentLocation(placeMark: CLPlacemark) {
        let locationString = "\(placeMark.locality), \(placeMark.administrativeArea), \(placeMark.country)"
        view?.updateCurrentLocation(location: locationString)
    }
}
