//
//  APIClient.swift
//  Movie Serial List
//
//  Created by Neosoft on 01/04/26.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    var authToken: String? = ""
    
//    private func toDictionary<T: Encodable>(_ value: T) -> [String: String]? {
//        do {
//            let data = try JSONEncoder().encode(value)
//            let json = try JSONSerialization.jsonObject(with: data)
//            return json as? [String: String]
//        } catch {
//            print("Encoding Dictionary error:", error)
//        }
//        return nil
//    }
    
    private func addQueryParam(url: URL, param: [String: String]?) -> URL? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
        var queries: [URLQueryItem] = []
        for (key, value) in param ?? [:] {
            queries.append(URLQueryItem(name: key, value: value))
        }
        components?.queryItems = queries
        
        return components?.url
    }
    
    func APIResponse<T: Decodable>(url: URL, methods: APIMethod, param: [String: String]? = nil, requiresAuth: Bool = false) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = methods.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth, let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if methods == .get {
            guard let url = addQueryParam(url: url, param: param) else {
                throw NetworkError.badURL
            }
            request.url = addQueryParam(url: url, param: param)
        } else if let body = param {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return try await callAPIResponse(request)
    }
    
    private func callAPIResponse<T: Decodable>(_ urlRequest: URLRequest) async throws -> T {
        guard let (data, response) = try? await URLSession.shared.data(for: urlRequest) else {
            throw NetworkError.dataInvalid
        }
        
        guard let httsResponse = response as? HTTPURLResponse,
              200...299 ~= httsResponse.statusCode else {
            throw NetworkError.responseInvalid
        }
                
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodeError
        }
    }
}
