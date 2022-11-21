//
//  NetworkError.swift
//  Pokedex11.15.22
//
//  Created by Consultant on 11/20/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badData
    case decodeFailure(DecodingError)
    case badStatusCode(Int)
    case serverError(Error)
    case other(Error)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Invalid request. Malformed URL. Report to Dev Team", comment: "bad url")
        case .badData:
            return NSLocalizedString("Data corrupted. Please Try again later.", comment: "bad data")
        case .decodeFailure:
            return NSLocalizedString("Invalid data. Please notify dev team.", comment: "decode failure")
        case .badStatusCode(let statusCode):
            return NSLocalizedString("Data could not be found or permission is not allowed. Status Code: \(statusCode)", comment: "bad status code")
        case .serverError:
            return NSLocalizedString("Something is wrong with the server. Report to the authorities", comment: "server error")
        case .other:
            return NSLocalizedString("Unknown Error. Quit using the app", comment: "Unknown error")
            
        }
        
    }
    
    
}
