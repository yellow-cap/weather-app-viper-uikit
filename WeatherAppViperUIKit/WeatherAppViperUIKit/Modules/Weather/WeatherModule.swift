import UIKit
import CoreLocation

class WeatherModule: IModule {
    func build() -> UIViewController {
        let view = WeatherView()
        let interaction = WeatherInteraction(
                locationService: LocationService(locationManager: CLLocationManager()),
                weatherService: WeatherService(
                        weatherForecastFetcher: WeatherForecastFetcher(
                                apiFetcher: ApiFetcher()
                        )
                )
        )
        let presenter = WeatherPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}
