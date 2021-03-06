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
        getPlaceMarkByLocation(location)
        getWeatherForecastForLocation(location)
    }

    func onLocationChangeFail(error: ServiceError) {
        presenter?.onGeneralError()
    }

    func onGetPlaceMarkByLocationSuccess(placeMark: CLPlacemark) {
        presenter?.updateCurrentLocation(placeMark: placeMark)
    }

    func onGetPlaceMarkByLocationFail(error: ServiceError) {
        presenter?.onGeneralError()
    }

    func onLocationPermissionsNotGranted() {
        presenter?.onPermissionsNotGranted()
    }

    private func getWeatherForecastForLocation(_ location: CLLocation) {
        do {
            let weatherForecast = try weatherService.getWeatherForecastForLocation(location: location)
            getCurrentWeatherIcon(weatherForecast)

            presenter?.updateWeather(weatherForecast: weatherForecast)
        } catch {
            presenter?.onGeneralError()
        }
    }

    private func getPlaceMarkByLocation(_ location: CLLocation) {
        locationService.getPlaceMarkByLocation(location: location)
    }

    private func getCurrentWeatherIcon(_ weatherForecast: WeatherForecast) {
        guard let weather = weatherForecast.current.weather.last else {
            presenter?.updateWeatherIcon(iconData: nil)
            return
        }
        do {
            let iconData = try weatherService.getCurrentWeatherIcon(iconCode: weather.icon)
            presenter?.updateWeatherIcon(iconData: iconData)
        } catch {
            print("Weather service: \(error.localizedDescription)")

            presenter?.updateWeatherIcon(iconData: nil)
        }
    }
}