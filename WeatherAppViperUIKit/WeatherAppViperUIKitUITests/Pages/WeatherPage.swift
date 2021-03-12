final class WeatherPage {
    private let e: Element

    init(_ element: Element) {
        e = element
    }

    var mainLocationLabel: Element {
        e.getStaticText(witId: "main_location_label")
    }

    var additionalLocationLabel: Element {
        e.getStaticText(witId: "additional_location_label")
    }

    var currentWeatherDescriptionLabel: Element {
        e.getStaticText(witId: "current_weather_description_label")
    }

    var currentTemperatureLabel: Element {
        e.getStaticText(witId: "current_temperature_label")
    }

    var currentWeatherIcon: Element {
        e.getImage(withId: "current_weather_icon")
    }

    var additionalWeatherParamsTable: Element {
        e.getTable(withId: "additional_weather_params_table")
    }

    var waitIsOpened: Bool {
        mainLocationLabel.waitIsExists()
    }
}
