import Foundation
import UIKit

protocol IWeatherView: IView {
    var presenter: IWeatherPresenter? { get set }
    func updateCurrentLocation(latitude: Double, longitude: Double)
}

class WeatherView: UIViewController, IWeatherView {
    var presenter: IWeatherPresenter?
    private var weatherAppLabel: UILabel = UILabel()

    override func loadView() {
        super.loadView()

        initView()
        placeView()
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
    }

    func updateCurrentLocation(latitude: Double, longitude: Double) {
        weatherAppLabel.text = "Your coordinates: latitude: \(latitude), longitude: \(longitude)"
    }

    private func initView() {
        weatherAppLabel.text = "Your coordinates: latitude: -, longitude: -"
        weatherAppLabel.textAlignment = .center
    }

    private func placeView() {
        view.addSubview(weatherAppLabel)

        weatherAppLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            weatherAppLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            weatherAppLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            weatherAppLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor)
        ])
    }
}

