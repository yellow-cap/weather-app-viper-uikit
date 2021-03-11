import Foundation
import UIKit

protocol IWeatherView: IView {
    var presenter: IWeatherPresenter? { get set }
    func updateCurrentLocation(location: (String, String))
    func updateWeather(
            temp: String,
            description: String,
            additionalWeatherParams: [(String, String)]
    )
    func updateWeatherIcon(image: UIImage)
    func showAlert(title: String, message: String)
}

class WeatherView: UIViewController, IWeatherView {
    var presenter: IWeatherPresenter?
    private let locationContainer: UIView = UIView()
    private let mainLocationLabel: UILabel = UILabel()
    private let additionalLocationLabel: UILabel = UILabel()

    private let currentWeatherContainer: UIView = UIView()
    private let currentWeatherDescriptionLabel: UILabel = UILabel()
    private let currentTemperatureLabel: UILabel = UILabel()
    private let currentWeatherIcon: UIImageView = UIImageView()

    private let additionalWeatherParamsTable = WeatherTableView()
    private var alert: UIAlertController? = nil


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
            description: String,
            additionalWeatherParams: [(String, String)]) {

        if !description.isEmpty {
            currentWeatherDescriptionLabel.text = description
            currentWeatherDescriptionLabel.isHidden = false
        }

        currentTemperatureLabel.text = temp
        currentTemperatureLabel.isHidden = false

        additionalWeatherParamsTable.update(data: additionalWeatherParams)
    }

    func updateWeatherIcon(image: UIImage) {
        currentWeatherIcon.image = image
        currentWeatherIcon.isHidden = false
    }

    func showAlert(title: String, message: String) {
        alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert

        )

        alert!.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { [unowned self] action in
            alert = nil
        })

        present(alert!, animated: true, completion: nil)
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

        currentWeatherIcon.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        currentWeatherIcon.isHidden = true
    }

    private func placeView() {
        placeLocationContainer()
        placeCurrentWeatherContainer()
        placeAdditionalWeatherParamsTable()
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
        let innerContainer = UIView()

        currentWeatherContainer.addSubview(currentWeatherDescriptionLabel)
        innerContainer.addSubview(currentTemperatureLabel)
        innerContainer.addSubview(currentWeatherIcon)
        currentWeatherContainer.addSubview(innerContainer)
        view.addSubview(currentWeatherContainer)

        currentWeatherContainer.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        innerContainer.translatesAutoresizingMaskIntoConstraints = false

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

            currentWeatherDescriptionLabel.centerXAnchor.constraint(equalTo: currentWeatherContainer.centerXAnchor),
            currentWeatherDescriptionLabel.leadingAnchor.constraint(equalTo: currentWeatherContainer.leadingAnchor),
            currentWeatherDescriptionLabel.trailingAnchor.constraint(equalTo: currentWeatherDescriptionLabel.trailingAnchor),

            innerContainer.topAnchor.constraint(equalTo: currentWeatherDescriptionLabel.bottomAnchor, constant: 20),
            innerContainer.centerXAnchor.constraint(equalTo: currentWeatherDescriptionLabel.centerXAnchor),

            currentWeatherIcon.leadingAnchor.constraint(equalTo: innerContainer.leadingAnchor),
            currentWeatherIcon.centerYAnchor.constraint(equalTo: currentTemperatureLabel.centerYAnchor),

            currentTemperatureLabel.leadingAnchor.constraint(equalTo: currentWeatherIcon.trailingAnchor),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: innerContainer.trailingAnchor)
        ])
    }

    private func placeAdditionalWeatherParamsTable() {
        view.addSubview(additionalWeatherParamsTable)

        additionalWeatherParamsTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            additionalWeatherParamsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            additionalWeatherParamsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            additionalWeatherParamsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            additionalWeatherParamsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

