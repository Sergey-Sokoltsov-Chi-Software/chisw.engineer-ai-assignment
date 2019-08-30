import Foundation

class NetworkManager {
    
    var session: URLSession
    
    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    @discardableResult
    func execute<T: Decodable>(type: T.Type, request: BaseRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request.createRequest()) { (data, taskResponse, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let response = taskResponse as? HTTPURLResponse else {
                    completion(.failure(NetworkError.commonError))
                    return
                }
                let networkResponse = self.handleResponse(response)
                switch networkResponse {
                case .success:
                    guard let data = data else {
                        completion(.failure(NetworkError.commonError))
                        return
                    }
                    do {
                        let responseModel = try JSONDecoder().decode(type, from: data)
                        completion(.success(responseModel))
                        return
                    } catch (let error) {
                        print("JSONDecoder error: ", error)
                        completion(.failure(NetworkError.commonError))
                        return
                    }
                default:
                    completion(.failure(networkResponse))
                    return
                }
            }
        }
        task.resume()
        return task
    }
    
    fileprivate func handleResponse(_ response: HTTPURLResponse) -> NetworkResponse {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .authenticationError
        case 501...599: return .badRequest
        case 600: return .outdated
        default: return .failed
        }
    }
    
}
