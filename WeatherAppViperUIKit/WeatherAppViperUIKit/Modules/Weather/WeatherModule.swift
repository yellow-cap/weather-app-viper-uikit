import UIKit

class WeatherModule: IModule {
    func build() -> UIViewController {
        let view = WeatherView()
        let interaction = WeatherInteraction()
        let presenter = WeatherPresenter()

        view.presenter = presenter

        presenter.interaction = interaction
        presenter.view = view

        interaction.presenter = presenter

        return view
    }
}
