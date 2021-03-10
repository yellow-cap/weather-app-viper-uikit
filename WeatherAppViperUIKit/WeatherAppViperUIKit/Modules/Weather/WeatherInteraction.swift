import CoreLocation

protocol IWeatherInteraction: IInteraction {
    var presenter: IWeatherPresenter? { get set }
    func initializeServices()
    func checkLocationServicesPermission()
}

class WeatherInteraction: IWeatherInteraction, LocationServiceDelegate {
    weak var presenter: IWeatherPresenter?
    private var locationService: ILocationService
    private let weatherService: IWeatherService

    init(locationService: ILocationService, weatherService: IWeatherService) {
        self.locationService = locationService
        self.weatherService = weatherService
    }

    func initializeServices() {
        locationService.delegate = self
    }

    func checkLocationServicesPermission() {
        locationService.checkLocationServicesPermission()
    }

    func onLocationChangeSuccess(location: CLLocation) {
        print("Current Location : \(location)")

        presenter?.updateCurrentLocation(
                latitude: Double(location.coordinate.latitude),
                longitude: Double(location.coordinate.longitude)
        )

        let service = WeatherService(
                weatherForecastFetcher: WeatherForecastFetcher(
                        apiFetcher: ApiFetcher()
                )
        )

        do {
            let result = try service.getWeatherForecastForLocation(location: location)
            print("RESULT \(result)")
        } catch {
            print("\(error)")
        }
    }

    func onLocationChangeFail(error: Error) {
        print("Error while trying to update device location : \(error)")
    }
}