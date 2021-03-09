import Foundation
import UIKit

protocol IWeatherView: IView {
    var presenter: IWeatherPresenter? { get set }
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
    }

    private func initView() {
        weatherAppLabel.text = "Weather app"
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

