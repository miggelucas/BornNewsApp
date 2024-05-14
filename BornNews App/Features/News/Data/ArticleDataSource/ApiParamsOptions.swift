//
//  ApiParamsOptions.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import Foundation

enum ApiKey {
    static var key: String {
        return "apiKey"
    }
    
    static var value: String {
//        return "f83edef801734100bac6b68e410e4364" // personal
        return "b3ae1fef9e1c4161a5718b525911973a" // ufpe
    }
}

enum CategoryOption: String {
    case business, entertainment, general, health, science, sports, technology
    
    var key: String {
        return "category"
    }
    
    var value: String {
        self.rawValue
    }
}

enum CountryOption: String {
    case unitedStates, brazil, argentina, canada, france, japan, china
    
    var name: String {
        switch self {
        case .unitedStates:
            "United States"
        case .brazil:
            "Brazil"
        case .argentina:
            "Argentina"
        case .canada:
            "Canada"
        case .france:
            "France"
        case .japan:
            "Japan"
        case .china:
            "China"
        }
    }
    
    var key: String {
        return "country"
    }
    
    var value: String {
        switch self {
        case .unitedStates:
            return "us"
        case .brazil:
            return "br"
        case .argentina:
            return "ar"
        case .canada:
            return "ca"
        case .france:
            return "fr"
        case .japan:
            return "jp"
        case .china:
            return "ch"
        }
    }
}
