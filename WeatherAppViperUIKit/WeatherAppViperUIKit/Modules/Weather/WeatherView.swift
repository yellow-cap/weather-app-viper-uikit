import Foundation
import UIKit

protocol IWeatherView: IView {
    var presenter: IWeatherPresenter? { get set }
    func updateCurrentLocation(location: (String, String))
}

class WeatherView: UIViewController, IWeatherView {
    var presenter: IWeatherPresenter?
    private var locationContainer: UIView = UIView()
    private var mainLocationLabel: UILabel = UILabel()
    private var additionalLocationLabel: UILabel = UILabel()

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

    private func initView() {
        mainLocationLabel.textAlignment = .center
        mainLocationLabel.font = UIFont.systemFont(ofSize: 32.0, weight: .regular)
        mainLocationLabel.backgroundColor = UIColor.yellow
        mainLocationLabel.isHidden = true

        additionalLocationLabel.textAlignment = .center
        additionalLocationLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .medium)
        additionalLocationLabel.backgroundColor = UIColor.red
        additionalLocationLabel.isHidden = true
    }

    private func placeView() {
        placeLocationContainer()
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
            locationContainer.topAnchor.constraint(
                    greaterThanOrEqualTo: view.topAnchor,
                    constant: 80
            ),
            locationContainer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            locationContainer.heightAnchor.constraint(equalToConstant: 200),
            locationContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            mainLocationLabel.centerXAnchor.constraint(equalTo: locationContainer.centerXAnchor),

            additionalLocationLabel.topAnchor.constraint(equalTo: mainLocationLabel.bottomAnchor, constant: 4),
            additionalLocationLabel.centerXAnchor.constraint(equalTo: locationContainer.centerXAnchor)
        ])
    }
}

