import Foundation
import UIKit

protocol IWeatherView: IView {
    var presenter: IWeatherPresenter? { get set }
    func updateCurrentLocation(location: (String, String))
    func updateWeather(
            temp: String,
            feelsLike: String,
            description: String
    )
}

class WeatherView: UIViewController, IWeatherView {
    var presenter: IWeatherPresenter?
    private var locationContainer: UIView = UIView()
    private var mainLocationLabel: UILabel = UILabel()
    private var additionalLocationLabel: UILabel = UILabel()

    private var currentWeatherContainer: UIView = UIView()
    private var currentWeatherDescriptionLabel: UILabel = UILabel()
    private var currentTemperatureLabel: UILabel = UILabel()

    override func loadView() {
        super.loadView()
        initView()
        placeView()
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
    }

    func updateCurrentLocation(location: (String, String)) {
        if !location.0.isEmpty {
            mainLocationLabel.text = location.0
            mainLocationLabel.isHidden = false
        }

        if !location.1.isEmpty {
            additionalLocationLabel.text = location.1
            additionalLocationLabel.isHidden = false
        }
    }

    func updateWeather(
            temp: String,
            feelsLike: String,
            description: String) {

        if !description.isEmpty {
            currentWeatherDescriptionLabel.text = description
            currentWeatherDescriptionLabel.isHidden = false
        }

        currentTemperatureLabel.text = temp
        currentTemperatureLabel.isHidden = false
    }

    private func initView() {
        mainLocationLabel.textAlignment = .center
        mainLocationLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .regular)
        mainLocationLabel.isHidden = true

        additionalLocationLabel.textAlignment = .center
        additionalLocationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        additionalLocationLabel.isHidden = true

        currentWeatherDescriptionLabel.textAlignment = .center
        currentWeatherDescriptionLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
        currentWeatherDescriptionLabel.isHidden = true

        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 80.0, weight: .light)
        currentTemperatureLabel.isHidden = true

        // currentWeatherContainer.backgroundColor = UIColor.orange
        // currentTemperatureLabel.backgroundColor = UIColor.red
    }

    private func placeView() {
        placeLocationContainer()
        placeCurrentWeatherContainer()
    }

    private func placeLocationContainer() {
        locationContainer.addSubview(mainLocationLabel)
        locationContainer.addSubview(additionalLocationLabel)

        view.addSubview(locationContainer)

        locationContainer.translatesAutoresizingMaskIntoConstraints = false
        mainLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLocationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            locationContainer.leadingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: 20
            ),
            locationContainer.trailingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: -20
            ),
            locationContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 80),
            locationContainer.bottomAnchor.constraint(equalTo: additionalLocationLabel.bottomAnchor),
            locationContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mainLocationLabel.centerXAnchor.constraint(equalTo: locationContainer.centerXAnchor),
            mainLocationLabel.leadingAnchor.constraint(equalTo: locationContainer.leadingAnchor),
            mainLocationLabel.trailingAnchor.constraint(equalTo: locationContainer.trailingAnchor),

            additionalLocationLabel.topAnchor.constraint(equalTo: mainLocationLabel.bottomAnchor),
            additionalLocationLabel.centerXAnchor.constraint(equalTo: locationContainer.centerXAnchor),
            additionalLocationLabel.leadingAnchor.constraint(equalTo: locationContainer.leadingAnchor),
            additionalLocationLabel.trailingAnchor.constraint(equalTo: locationContainer.trailingAnchor)
        ])
    }

    private func placeCurrentWeatherContainer() {
        currentWeatherContainer.addSubview(currentWeatherDescriptionLabel)
        currentWeatherContainer.addSubview(currentTemperatureLabel)
        view.addSubview(currentWeatherContainer)

        currentWeatherContainer.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            currentWeatherContainer.leadingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: 20
            ),
            currentWeatherContainer.trailingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: -20
            ),

            currentWeatherContainer.topAnchor.constraint(equalTo: locationContainer.bottomAnchor, constant: 24),
            currentWeatherContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherContainer.heightAnchor.constraint(equalToConstant: 200),

            currentWeatherDescriptionLabel.centerXAnchor.constraint(equalTo: currentWeatherContainer.centerXAnchor),
            currentWeatherDescriptionLabel.leadingAnchor.constraint(equalTo: currentWeatherContainer.leadingAnchor),
            currentWeatherDescriptionLabel.trailingAnchor.constraint(equalTo: currentWeatherDescriptionLabel.trailingAnchor),

            currentTemperatureLabel.centerXAnchor.constraint(equalTo: currentWeatherContainer.centerXAnchor),
            currentTemperatureLabel.leadingAnchor.constraint(equalTo: currentWeatherContainer.leadingAnchor),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: currentWeatherDescriptionLabel.trailingAnchor),
            currentTemperatureLabel.topAnchor.constraint(equalTo: currentWeatherDescriptionLabel.bottomAnchor)
        ])
    }
}

