import Foundation

enum NetworkError: Error {
    case commonError
    
    var localizedDescription: String {
        switch self {
        case .commonError: return "commonError".localized()
        }
    }
}

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    
    var localizedDescription: String {
        switch self {
        case .success: return "Success".localized()
        case .authenticationError: return "authenticationError".localized()
        case .badRequest: return "badRequest".localized()
        case .outdated: return "requestOutdated".localized()
        case .failed: return "requestFailed".localized()
        }
    }
}

