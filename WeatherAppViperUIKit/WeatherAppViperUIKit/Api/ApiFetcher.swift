import Foundation

protocol IApiFetcher {
    func request(
            type: ApiRequestType,
            path: String,
            headers: [String: String],
            queryParams: [String: String]
    ) -> Result<Data?, ApiError>
}

class ApiFetcher: IApiFetcher {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    func request(
            type: ApiRequestType,
            path: String,
            headers: [String: String],
            queryParams: [String: String]
    )-> Result<Data?, ApiError> {

        guard let url = buildRequestUrl(path: path, queryParams: queryParams) else {
            return .failure(
                    ApiError(message: "ApiFetcher: Couldn't build request url.")
            )
        }

        var request = URLRequest(url: url)

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        request.httpMethod = type.rawValue

        var result: Result<Data?, ApiError>!
        let semaphore = DispatchSemaphore(value: 0)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                result = .failure(
                        ApiError(message: "ApiFetcher: Api response error \(error.localizedDescription).")
                )

                semaphore.signal()

                return
            }

            guard let response = response as? HTTPURLResponse else {
                result = .failure(
                        ApiError(message: "ApiFetcher: Couldn't get response as HTTPURLResponse.")
                )
                semaphore.signal()

                return
            }

            guard response.statusCode == 200 else {
                result = .failure(
                        ApiError(message: "ApiFetcher: Api response code: \(response.statusCode).")
                )
                semaphore.signal()

                return
            }

            guard let data = data else {
                result = .failure(
                        ApiError(message: "ApiFetcher: Couldn't get data from response")
                )
                semaphore.signal()

                return
            }

            result = .success(data)

            semaphore.signal()
        }

        task.resume()

        _ = semaphore.wait(wallTimeout: .distantFuture)

        return result
    }

    private func buildRequestUrl(path: String, queryParams: [String: String]) -> URL? {
        guard let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }

        guard var urlComponents = URLComponents(string: encodedPath) else {
            return nil
        }

        urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        urlComponents.queryItems = queryParams.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }

        return urlComponents.url
    }
}
