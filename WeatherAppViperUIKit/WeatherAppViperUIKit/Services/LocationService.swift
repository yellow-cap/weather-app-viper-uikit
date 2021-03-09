import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func onLocationChangeSuccess(location: CLLocation)
    func onLocationChangeFail(error: Error)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    var delegate: LocationServiceDelegate?
    var locationManager: CLLocationManager!

    init(locationManager: CLLocationManager) {
        super.init()
        self.locationManager = locationManager
    }

    func initialize() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Access to location restricted.")
        case .denied:
            print("Access to location denied.")
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            print("Access to location granted. Always.")
            startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Access to location granted. When app in use.")
            startUpdatingLocation()
        default:
            print("Unhandled error occurred.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("Couldn't get location")
            return
        }

        onLocationChangeSuccess(location: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stopUpdatingLocation()

        onLocationChangeFail(error: error)
    }

    private func onLocationChangeSuccess(location: CLLocation) {
        guard let delegate = delegate else {
            return
        }

        delegate.onLocationChangeSuccess(location: location)
    }

    private func onLocationChangeFail(error: Error) {
        guard let delegate = delegate else {
            return
        }

        delegate.onLocationChangeFail(error: error)
    }
}