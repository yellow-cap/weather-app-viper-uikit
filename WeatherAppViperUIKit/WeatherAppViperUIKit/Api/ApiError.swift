struct ApiError: Error {
    let message: String

    init(message: String) {
        self.message = message
    }
}