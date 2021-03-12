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
    private let mainLocationLabel: UILabel = UILabel()
    private let additionalLocationLabel: UILabel = UILabel()

    private let currentWeatherContainer = UIView()
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
        }

        currentTemperatureLabel.text = temp

        additionalWeatherParamsTable.update(data: additionalWeatherParams)
    }

    func updateWeatherIcon(image: UIImage) {
        currentWeatherIcon.image = image
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
        mainLocationLabel.text = StringResources.locationDefaultString

        additionalLocationLabel.textAlignment = .center
        additionalLocationLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        additionalLocationLabel.text = StringResources.locationDefaultString

        currentWeatherDescriptionLabel.textAlignment = .center
        currentWeatherDescriptionLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
        currentWeatherDescriptionLabel.text = StringResources.conditionsDefaultString

        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 80.0, weight: .light)
        currentTemperatureLabel.text = 0.0.toStringCelsius()

        currentWeatherIcon.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        currentWeatherIcon.image = UIImage(named: "DefaultWeatherImage")!
    }

    private func placeView() {
        placeLocation()
        placeWeather()
        placeAdditionalWeatherParamsTable()
    }

    private func placeLocation() {
        view.addSubview(mainLocationLabel)
        view.addSubview(additionalLocationLabel)

        mainLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLocationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainLocationLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 80),
            mainLocationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLocationLabel.leadingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: 20),
            mainLocationLabel.trailingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: -20),

            additionalLocationLabel.topAnchor.constraint(equalTo: mainLocationLabel.bottomAnchor),
            additionalLocationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            additionalLocationLabel.leadingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: 20),
            additionalLocationLabel.trailingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: -20),
        ])
    }

    private func placeWeather() {
        view.addSubview(currentWeatherDescriptionLabel)
        currentWeatherContainer.addSubview(currentTemperatureLabel)
        currentWeatherContainer.addSubview(currentWeatherIcon)
        view.addSubview(currentWeatherContainer)

        currentWeatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentWeatherContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            currentWeatherDescriptionLabel.leadingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.leadingAnchor,
                    constant: 20
            ),
            currentWeatherDescriptionLabel.trailingAnchor.constraint(
                    greaterThanOrEqualTo: view.layoutMarginsGuide.trailingAnchor,
                    constant: -20
            ),

            currentWeatherDescriptionLabel.topAnchor.constraint(equalTo: additionalLocationLabel.bottomAnchor, constant: 24),
            currentWeatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            currentWeatherContainer.topAnchor.constraint(equalTo: currentWeatherDescriptionLabel.bottomAnchor, constant: 20),
            currentWeatherContainer.centerXAnchor.constraint(equalTo: currentWeatherDescriptionLabel.centerXAnchor),
            currentWeatherContainer.heightAnchor.constraint(equalToConstant: 80),

            currentWeatherIcon.leadingAnchor.constraint(equalTo: currentWeatherContainer.leadingAnchor),
            currentWeatherIcon.centerYAnchor.constraint(equalTo: currentTemperatureLabel.centerYAnchor),

            currentTemperatureLabel.leadingAnchor.constraint(equalTo: currentWeatherIcon.trailingAnchor),
            currentTemperatureLabel.trailingAnchor.constraint(equalTo: currentWeatherContainer.trailingAnchor)
        ])
    }

    private func placeAdditionalWeatherParamsTable() {
        view.addSubview(additionalWeatherParamsTable)

        additionalWeatherParamsTable.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            additionalWeatherParamsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            additionalWeatherParamsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            additionalWeatherParamsTable.topAnchor.constraint(equalTo: currentWeatherContainer.bottomAnchor),
            additionalWeatherParamsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

