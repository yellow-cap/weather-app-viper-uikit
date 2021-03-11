import Foundation

extension Date {
    func getTimeString(_ pattern: String = "HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = pattern

        return formatter.string(from: self)
    }
}
