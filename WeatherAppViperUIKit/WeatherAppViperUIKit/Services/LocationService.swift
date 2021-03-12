import Foundation
import CoreLocation
import MapKit

protocol LocationServiceDelegate {
    func onLocationChangeSuccess(location: CLLocation)
    func onLocationChangeFail(error: ServiceError)
    func onGetPlaceMarkByLocationSuccess(placeMark: CLPlacemark)
    func onGetPlaceMarkByLocationFail(error: ServiceError)
    func onLocationPermissionsNotGranted()
}

protocol ILocationService {
    var delegate: LocationServiceDelegate? { get set }
    func checkLocationServicesPermission()
    func getPlaceMarkByLocation(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate, ILocationService {
    var delegate: LocationServiceDelegate?
    private let locationManager: CLLocationManager = CLLocationManager()
    private let geoCoder: CLGeocoder = CLGeocoder()

    override init() {
        super.init()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location service: Access to location restricted.")
            onLocationPermissionNotGranted()
        case .denied:
            print("Location service: Access to location denied.")
            onLocationPermissionNotGranted()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            print("Access to location granted. Always.")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Access to location granted. When app in use.")
            locationManager.startUpdatingLocation()
        default:
            onLocationChangeFail(error: ServiceError(
                    message: "Location service: Unhandled error.")
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            onLocationChangeFail(error: ServiceError(
                    message: "Location service: Couldn't get location.")
            )
            return
        }

        onLocationChangeSuccess(location: location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        switch manager.authorizationStatus {
        case .notDetermined, .restricted, .denied:
            return
        default:
            locationManager.stopUpdatingLocation()

            onLocationChangeFail(
                    error: ServiceError(
                            message: "Location service: Couldn't get current location \(error.localizedDescription)")
            )
        }
    }

    func checkLocationServicesPermission() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.startUpdatingLocation()
            default:
               print("Location service: Access to location restricted. Check Location services settings.")
                onLocationPermissionNotGranted()
            }
        } else {
            onLocationChangeFail(error: ServiceError(
                    message: "Location service: Service is not available.")
            )
        }
    }

    func getPlaceMarkByLocation(location: CLLocation) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.geoCoder.reverseGeocodeLocation(location) { placeMark, error in
                if let error = error {

                    DispatchQueue.main.async {
                        self?.onGetPlaceMarkByLocationFail(
                                ServiceError(
                                        message: "Location service: Couldn't get placemark from geoCoder: \(error.localizedDescription)"
                                )
                        )
                    }

                    return
                }

                guard let placeMark = placeMark, placeMark.last != nil else {
                    DispatchQueue.main.async {
                        self?.onGetPlaceMarkByLocationFail(
                                ServiceError(
                                        message: "Location service: Placemark is not defined"
                                )
                        )
                    }

                    return
                }

                DispatchQueue.main.async {
                    self?.onGetPlaceMarkByLocationSuccess(placeMark.last!)
                }
            }
        }
    }

    private func onLocationChangeSuccess(location: CLLocation) {
        guard let delegate = delegate else {
            return
        }

        delegate.onLocationChangeSuccess(location: location)
    }

    private func onLocationChangeFail(error: ServiceError) {
        guard let delegate = delegate else {
            return
        }

        print("Location service error: \(error.message)")
        delegate.onLocationChangeFail(error: error)
    }

    private func onGetPlaceMarkByLocationSuccess(_ placeMark: CLPlacemark) {
        guard let delegate = delegate else {
            return
        }

        delegate.onGetPlaceMarkByLocationSuccess(placeMark: placeMark)
    }

    private func onGetPlaceMarkByLocationFail(_ error: ServiceError) {
        guard let delegate = delegate else {
            return
        }

        delegate.onGetPlaceMarkByLocationFail(error: error)
    }

    private func onLocationPermissionNotGranted() {
        guard let delegate = delegate else {
            return
        }

        delegate.onLocationPermissionsNotGranted()
    }
}