//
//  InterfaceError.swift
//  UIComponents
//
//  Created by Daniel Mandea on 24.08.2022.
//  Copyright © 2023 MTD Technology(publ). All rights reserved.
//

import Foundation

enum InterfaceError: Error, LocalizedError, Identifiable {
    case internalError
    case networkError
    case specialized(error: LocalizedError)
    case unknown(message: String)
    
    var id: String {
        switch self {
        case .internalError:
            return "invalid_error"
        case .networkError:
            return "network_error"
        case .specialized:
            return "specialized_error"
        case .unknown:
            return "unknown_error"
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .internalError:
            return L10n.internalErrorTitle
        case .networkError:
            return L10n.networkErrorTitle
        case .specialized(error: let error):
            return error.errorDescription
        case .unknown(message: let message):
            return message
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .internalError:
            return L10n.internalErrorMessage
        case .networkError:
            return L10n.networkErrorMessage
        case .specialized(error: let error):
            return error.recoverySuggestion
        case .unknown(message: let message):
            return message
        }
    }
}
