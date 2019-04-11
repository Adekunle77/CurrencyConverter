//
//  MockAPI.swift
//  CurrencyConvertorTests
//
//  Created by Ade Adegoke on 06/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

@testable import CurrencyConvertor

class MockAPI: API {
    
    var isReturningError = false
    
    func fetchAPIData(endPoint: Endpoint, completion: @escaping CompletionHandler) {
        
        if isReturningError == true {
            completion(.failure(.noData))
        } else {
            if endPoint.path.rawValue == Path.country.rawValue {
                let data = Countries(results: ["results" : CountriesInfo(alpha3: "AFG", currencyId: "AFN", currencyName: "Afghan afghani", currencySymbol: "؋", id: "AF", name: "Afghanistan")])
                completion(.success(.country(data)))
            }

            if endPoint.path.rawValue == Path.convert.rawValue {
                let data: [String: Double] = ["GBP_USD" : 1.304887]
                completion(.success(.convert(data)))
            }
            print("test")
            if endPoint.path.rawValue == Path.currencies.rawValue {
                let data = Currencies(results: ["results" : CurrenciesInfo(currencyName: "Albanian Lek", currencySymbol: "Lek", id: "ALL")])
                completion(.success(.currency(data)))
            }
        }
    }
}
