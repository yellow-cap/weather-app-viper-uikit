class ApiUrlBuilder {
    private static let openWeatherApiBaseUrl = "https://api.openweathermap.org"

    public static func getCurrentLocationForecastUrl() -> String {
        "\(openWeatherApiBaseUrl)/data/2.5/onecall"
    }

    public static func getCurrentWeatherIcon(iconCode: String) -> String {
        "\(openWeatherApiBaseUrl)/img/wn/\(iconCode)@2x.png"
    }
}