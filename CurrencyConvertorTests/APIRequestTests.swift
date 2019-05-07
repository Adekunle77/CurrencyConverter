//
//  APIRequestTests.swift
//  CurrencyConvertorTests
//
//  Created by Ade Adegoke on 30/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest

@testable import CurrencyConvertor

class APIRequestTests: XCTestCase {

    func testParseConvertedCurrencyJson() {
        let apiRequest = APIRequest()
        let jsonData: [String: Double] = ["GBP_USD" : 1.304887]
        
        if let path = Bundle.main.path(forResource: "ConvertedCurrencyTest", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try apiRequest.testParseConvertedCurrencyJson(data: data)
                
         XCTAssertEqual(jsonData, jsonResult)
            } catch {
                print("failed")
            }
        }
    }
    
    func testParseCurrenciesJson() {
        let apiRequest = APIRequest()
        let jsonData = Currencies(results: ["results" : CurrenciesInfo(currencyName: "Albanian Lek", currencySymbol: "Lek", id: "ALL")])
        
        if let path = Bundle.main.path(forResource: "CurrencyTest", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try apiRequest.testParseCurrenciesJson(data: data)
                XCTAssertEqual(jsonData, jsonResult)
            } catch {
                print("failed")
            }
        }
    }
    
    func testParseCountryJson() {
        let apiRequest = APIRequest()
        let jsonData = Countries(results: ["results" : CountriesInfo(alpha3: "AFG", currencyId: "AFN", currencyName: "Afghan afghani", currencySymbol: "؋", id: "AF", name: "Afghanistan")])
        
        if let path = Bundle.main.path(forResource: "CountriesTest", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try apiRequest.testParseCountryJson(data: data)
                
                XCTAssertEqual(jsonData, jsonResult)
            } catch {
                print("failed")
            }
        }
    }
}
