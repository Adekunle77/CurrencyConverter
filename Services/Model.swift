//
//  Data.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 05/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation


struct Currencies: Codable {
    let results: [String: CurrenciesInfo]
    
}

struct CurrenciesInfo: Codable {
    let currencyName: String?
    let currencySymbol: String?
    let id: String?
}

struct Countries: Codable {
    let results: [String: CountriesInfo]
    
}

struct CountriesInfo: Codable {
    let alpha3: String
    let currencyId: String
    let currencyName: String
    let currencySymbol: String
    let id: String
    let name: String
    
    enum keys: String, CodingKey {
        case alpha = "alpha3"
    }
}


extension Currencies: Equatable {
    static func == (lhs: Currencies, rhs: Currencies) -> Bool {
        let areEqual = lhs.results == rhs.results &&
            lhs.results == rhs.results
        
        return areEqual
    }
}

extension CurrenciesInfo: Equatable {
    static func == (lhs: CurrenciesInfo, rhs: CurrenciesInfo) -> Bool {
        let areEqual = lhs.currencyName == rhs.currencyName &&
            lhs.currencySymbol == rhs.currencySymbol && lhs.id == rhs.id
        
        return areEqual
    }
}

extension Countries: Equatable {
    static func == (lhs: Countries, rhs: Countries) -> Bool {
        let areEqual = lhs.results == rhs.results &&
            lhs.results == rhs.results
        
        return areEqual
    }
}

extension CountriesInfo: Equatable {
    static func == (lhs: CountriesInfo, rhs: CountriesInfo) -> Bool {
        let areEqual = lhs.alpha3 == rhs.alpha3 && lhs.currencyId == rhs.currencyId && lhs.currencyName == rhs.currencyName && lhs.currencySymbol == rhs.currencySymbol && lhs.id == rhs.id && lhs.name == rhs.name
        
        return areEqual
    }
}
