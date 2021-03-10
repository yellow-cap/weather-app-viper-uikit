class ApiUrlBuilder {
    private static let openWeatherApiBaseUrl = "https://api.openweathermap.org"

    public static func getCurrentLocationForecastUrl() -> String {
        "\(openWeatherApiBaseUrl)/data/2.5/onecall"
    }
}