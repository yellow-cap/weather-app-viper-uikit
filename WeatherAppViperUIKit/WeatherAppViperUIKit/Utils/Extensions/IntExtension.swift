import Foundation

extension Int {
    func toStringPercents() -> String {
        "\(self) %"
    }

    func toDate(timeZoneOffset: Double = 0.0) -> Date {
        let timeInterval = TimeInterval(self)
        return Date(
                timeIntervalSince1970: (TimeInterval(timeInterval))
        )
    }
}
