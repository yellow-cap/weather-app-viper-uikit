import Foundation

extension Date {
    func getTimeStringForeTimeZone(_ pattern: String = "HH:mm", timeZone: TimeZone = TimeZone.current) -> String {
        let dateWithTimeZone = convertToTimeZone(initTimeZone: TimeZone.current, timeZone: timeZone)
        let formatter = DateFormatter()
        formatter.dateFormat = pattern

        return formatter.string(from: dateWithTimeZone)
    }

    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
        let delta = TimeInterval(timeZone.secondsFromGMT(for: self) - initTimeZone.secondsFromGMT(for: self))
        return addingTimeInterval(delta)
    }
}
