class ApiUrlBuilder {
    private static let openWeatherApiBaseUrl = "https://api.openweathermap.org"
    private static let openWeatherBaseUrl = "https://openweathermap.org"

    public static func getCurrentLocationForecastUrl() -> String {
        "\(openWeatherApiBaseUrl)/data/2.5/onecall"
    }

    public static func getCurrentWeatherIcon(iconCode: String) -> String {
        "\(openWeatherBaseUrl)/img/wn/\(iconCode)@2x.png"
    }
}