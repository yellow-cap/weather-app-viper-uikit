protocol IWeatherInteraction: IInteraction {
    var presenter: IWeatherPresenter? { get set }
}

class WeatherInteraction: IWeatherInteraction {
    weak var presenter: IWeatherPresenter?
}