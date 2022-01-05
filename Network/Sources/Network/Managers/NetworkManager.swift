//
//  File.swift
//  
//
//  Created by Emrah Akgül on 5.01.2022.
//

import Foundation

public protocol NetworkManageable {

    func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> ())
}

public extension Encodable {

    func toJSONData(jsonEncoder: JSONEncoder) -> Data? { try? jsonEncoder.encode(self) }
}

public final class NetworkManager: NetworkManageable {

    public static let `default`: NetworkManager = NetworkManager()

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    private func getURL(from request: Request) -> URL? {
        var components = URLComponents()
        components.scheme = request.scheme
        components.host = request.baseURL
        components.path = request.path
        components.queryItems = request.parameters
        return components.url
    }

    private func getURLRequest(from request: Request, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.url = url
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let body = request.body {
            urlRequest.httpBody = body.toJSONData(jsonEncoder: NetworkManager.encoder)
        }
        return urlRequest
    }

    public func execute<T: Decodable>(request: Request, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = getURL(from: request) else {
            completion(.failure(NetworkError.corruptedURL))
            return
        }
        let urlRequest = getURLRequest(from: request, url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    #if DEBUG
                    print("No Response!")
                    #endif
                    completion(.failure(NetworkError.other))
                    return
                }
                if let error = error {
                    #if DEBUG
                    print("Connection Error: " + error.localizedDescription)
                    #endif
                    completion(.failure(NetworkError.connection(reason: error)))
                    return
                }
                if response.statusCode < 200 || response.statusCode >= 400 {
                    #if DEBUG
                    print("HTTP Error: " + String(describing: response.statusCode))
                    #endif
                    completion(.failure(NetworkError.http(code: response.statusCode)))
                }
                else {
                    guard let data = data else {
                        #if DEBUG
                        print("No Data!")
                        #endif
                        completion(.failure(NetworkError.data(reason: .missing)))
                        return
                    }
                    do {
                        let response = try NetworkManager.decoder.decode(T.self, from: data)
                        completion(.success(response))
                    } catch let error as DecodingError {
                        completion(.failure(NetworkError.data(reason: .read(underlying: error))))
                    } catch {
                        completion(.failure(NetworkError.other))
                    }
                }
            }
        }
        dataTask.resume()
    }
}
