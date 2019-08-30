import Foundation

class BaseRequest {
    
    var baseURL: String = "https://hn.algolia.com/api/v1"
    var path: String = ""
    var method: HTTPMethod = .get
    var queryParameters: [String: String]?
    var headers: [String: String]?
    var bodyParameters: [String: Any]?
    
    init(baseURL: String? = nil, path: String? = nil, method: HTTPMethod? = nil, queryParameters: [String: String]? = nil, headers: [String: String]? = nil, bodyParameters: [String: Any]? = nil) {
        
        if let path = path {
            self.path = path
        }
        if let method = method {
            self.method = method
        }
        self.queryParameters = queryParameters
        self.headers = headers
        self.bodyParameters = bodyParameters
    }
    
    func createRequest() -> URLRequest {
        
        var fullPath: String = "\(baseURL)"
        if !path.isEmpty {
            fullPath.append("/\(path)")
        }
        var urlWithComponents = URLComponents(string: fullPath)
        
        if let parameters = queryParameters {
            var queryItems = [URLQueryItem]()
            for (name, value) in parameters {
                queryItems.append(URLQueryItem(name: name, value: value))
            }
            urlWithComponents?.queryItems = queryItems
        }
        var request = URLRequest(url: (urlWithComponents?.url)!)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let parameters = bodyParameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return request
    }
}
