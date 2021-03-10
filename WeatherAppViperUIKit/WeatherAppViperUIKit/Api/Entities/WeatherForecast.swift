import Foundation

struct WeatherForecast: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: WeatherFull
}
