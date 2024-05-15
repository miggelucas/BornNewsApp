//
//  ApiParamsOptions.swift
//  BornNews App
//
//  Created by Lucas Migge on 13/05/24.
//

import Foundation

enum EndPointsOption {
    case headlines
    case everything
    
    var code: String {
        switch self {
        case .everything:
            return "https://newsapi.org/v2/everything"
            
        case .headlines:
            return "https://newsapi.org/v2/top-headlines"
        }
    }
}

protocol ApiParamOption {
    var key: String { get }
    
    var value: String { get }
}

enum ApiKey: ApiParamOption {
    case personal, ufpe
    
    var key: String {
        return "apiKey"
    }
    
    var value: String {
        switch self {
        case .personal:
            return "f83edef801734100bac6b68e410e4364"
        case .ufpe:
            return "b3ae1fef9e1c4161a5718b525911973a"
        }
    }
}

enum CategoryOption: String, ApiParamOption {
    case business, entertainment, general, health, science, sports, technology
    
    var key: String {
        return "category"
    }
    
    var value: String {
        self.rawValue
    }
}

enum CountryOption: String, ApiParamOption {
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

enum LanguageOption: String, ApiParamOption {
    case english, spanish, portuguese, french
    
    var name: String {
        return self.rawValue
    }
    
    var key: String {
        return "language"
    }
    
    var value: String {
        switch self {
        case .english:
            return "en"
        case .spanish:
            return "es"
        case .portuguese:
            return "pt"
        case .french:
            return "fc"
        }
    }
}

struct QueryOption: ApiParamOption {
    
    let queryFor: String
    
    var key: String {
        return "q"
    }
    
    var value: String {
        return queryFor
    }
}
