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

        getPlaceMarkByLocation(location)

        presenter?.updateCurrentLocation(
                latitude: Double(location.coordinate.latitude),
                longitude: Double(location.coordinate.longitude)
        )

        do {
            let result = try weatherService.getWeatherForecastForLocation(location: location)
        } catch {
            print("\(error)")
        }
    }

    func onLocationChangeFail(error: ServiceError) {
        print(error.message)
    }

    func onGetPlaceMarkByLocationSuccess(placeMark: [CLPlacemark]) {
        print(placeMark)
    }

    func onGetPlaceMarkByLocationFail(error: ServiceError) {
        print(error.message)
    }

    private func getPlaceMarkByLocation(_ location: CLLocation) {
        locationService.getPlaceMarkByLocation(location: location)
    }
}