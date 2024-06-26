//
//  HTTPAccessing.swift
//  Created by Kiro Shin <mulgom@gmail.com> on 2024.
//
// Ref: https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
//      https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
//      https://developer.apple.com/documentation/foundation/nserror/
//


import Foundation

typealias HTTPStatusCode = Int


enum HTTPError: Error {
    case webFailed(code: HTTPStatusCode, name: String)
    case networkFailed(reason: String)
    case decodeFailed(reason: String)
}


protocol HTTPAccessing: HTTPGetting, HTTPPosting {}
protocol HTTPGetting {}
protocol HTTPPosting {}


extension HTTPGetting {
    /// GET 데이터 태스크 제이슨
    func getJson<T: Decodable>(detype: T.Type,
                               url: URL,
                               headers: [String : String] = ["Accept": "application/json"]
    ) async throws -> (T, HTTPStatusCode) { do {
        let request = URLRequest(url: url, method: .GET, headers: headers)
        let (data, response) = try await URLSession.shared.data(for: request)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.isSuccess {
            let output = try JSONDecoder().decode(detype.self, from: data)
            return (output, httpResponse.statusCode)
        }
        throw HTTPError.webFailed(code: httpResponse.statusCode, name: httpResponse.statusName)
    } catch let error as DecodingError {
        throw HTTPError.decodeFailed(reason: error.localizedDescription)     // NSCoderError
    } catch {
        throw HTTPError.networkFailed(reason: error.localizedDescription)    // NSURLError
    } }

}


private extension URLRequest {
    enum HTTPMethod: String {
        case GET, POST, PUT, PATCH, DELETE
    }
    
    init(url: URL, method: HTTPMethod, timeout: TimeInterval = 15.0, headers: [String : String]? = nil, body: Data? = nil) {
        self.init(url: url, timeoutInterval: timeout)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
        httpBody = body
    }
    
}


private extension HTTPURLResponse {
    var isSuccess: Bool { (200..<300).contains(statusCode) }
    var statusName: String { Self.localizedString(forStatusCode: statusCode) }
}

