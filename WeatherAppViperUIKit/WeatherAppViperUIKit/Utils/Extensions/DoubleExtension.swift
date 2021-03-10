import Foundation

extension Double {
    func toStringCelsius() -> String {
        "\(Int(self))\u{00B0}"
    }

    func toStringMetersPerSec() -> String {
        "\(self) m/s"
    }

    func toStringPressureMmHg() -> String {
        let mmHg = (self / 1.33).roundDouble(to: 2)
        return "\(mmHg) mm Hg"
    }

    func toStringKm() -> String {
        let km = (self / 1000).roundDouble(to: 2)
        return "\(km) km"
    }

    func roundDouble(to digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return Double((self * multiplier).rounded() / multiplier)
    }
}
