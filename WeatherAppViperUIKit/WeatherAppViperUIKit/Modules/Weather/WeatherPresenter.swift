import Foundation

protocol IWeatherPresenter: IPresenter {
    var interaction: IWeatherInteraction? { get set }
    var view: IWeatherView? { get set }
}

class WeatherPresenter: IWeatherPresenter {
    var interaction: IWeatherInteraction?
    weak var view: IWeatherView?
}
