import Foundation

protocol IWeatherPresenter: IPresenter {
    var interaction: IWeatherInteraction? { get set }
    var view: IWeatherView? { get set }
    func viewDidLoad()
    func updateCurrentLocation(latitude: Double, longitude: Double)
}

class WeatherPresenter: IWeatherPresenter {
    var interaction: IWeatherInteraction?
    weak var view: IWeatherView?

    func viewDidLoad() {
        interaction?.initializeLocationService()
    }

    func updateCurrentLocation(latitude: Double, longitude: Double) {
        view?.updateCurrentLocation(latitude: latitude, longitude: longitude)
    }
}
