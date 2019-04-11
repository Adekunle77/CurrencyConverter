//
//  DisplayViewModelTest.swift
//  CurrencyConvertorTests
//
//  Created by Ade Adegoke on 09/04/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import XCTest

@testable import CurrencyConvertor

class DisplayViewModelTest: XCTestCase {
    
        class ViewModelDelegateSpy: ViewModelDelegate {
            
            var spyModelDidUpdateData = false
            var spyModelDidUpdateWithError: Error?
            
            func modelDidUpdateData() {
                spyModelDidUpdateData = true
            }
            
            func modelDidUpdateWithError(error: Error) {
                spyModelDidUpdateWithError = error
            }
        }

    var mockApi = MockAPI()

    func testFetchCurrenciesReturnsError() {
        mockApi.isReturningError = true
        let spy = ViewModelDelegateSpy()
        let viewModel = DisplayViewModel(dataSource: mockApi)
        
        viewModel.delegate = spy
        
        viewModel.fetchCurrencies()
        
        XCTAssertFalse(spy.spyModelDidUpdateData)
        XCTAssertNotNil(spy.spyModelDidUpdateWithError)
    }
    
    func testFetchCurrenciesReturnsSuccess() {
        mockApi.isReturningError = false
        let spy = ViewModelDelegateSpy()
        let viewModel = DisplayViewModel(dataSource: mockApi)
        
        viewModel.delegate = spy
        
        viewModel.fetchCurrencies()
        
        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateWithError)
        
    }
    
    
    func testConvertReturnsError() {
        mockApi.isReturningError = true
        let viewModel = DisplayViewModel(dataSource: mockApi)
        let spy = ViewModelDelegateSpy()
        
        viewModel.delegate = spy
        
        viewModel.convert(currencies: "GBP_USD")
        
        XCTAssertFalse(spy.spyModelDidUpdateData)
        XCTAssertNotNil(spy.spyModelDidUpdateWithError)
        
    }
    
    func testConvertReturnsSuccess() {
        mockApi.isReturningError = false
        let spy = ViewModelDelegateSpy()
        let viewModel = DisplayViewModel(dataSource: mockApi)
        
        viewModel.delegate = spy
        
        viewModel.convert(currencies: "GBP_USD")
        
        XCTAssertTrue(spy.spyModelDidUpdateData)
        XCTAssertNil(spy.spyModelDidUpdateWithError)
    }
    
    func testJoinCurrencies() {
        mockApi.isReturningError = false
        let viewModel = DisplayViewModel(dataSource: mockApi)
        
        var currencyOne: CurrencyTuple
        currencyOne.id = "GBP"
        currencyOne.name = "British Pound"
        currencyOne.symbol = "£"
        
        var currencyTwo: CurrencyTuple
        currencyTwo.id = "USD"
        currencyTwo.name = "United States Dollar"
        currencyTwo.symbol = "$"
        
        
        let joinCurrencyGPBUSD = viewModel.joinCurrencies(with: currencyOne, and: currencyTwo)
        XCTAssertEqual(joinCurrencyGPBUSD, "GBP_USD")
        
        let joinCurrencyUSDGPB = viewModel.joinCurrencies(with: currencyTwo, and: currencyOne)
        XCTAssertEqual(joinCurrencyUSDGPB, "USD_GBP")
    }
    
    func testIterate() {
        mockApi.isReturningError = false
        let viewModel = DisplayViewModel(dataSource: mockApi)
        var currencyOne: CurrencyTuple
        currencyOne.id = "GBP"
        currencyOne.name = "British Pound"
        currencyOne.symbol = "£"
        
        var currencyTwo: CurrencyTuple
        currencyTwo.id = "USD"
        currencyTwo.name = "United States Dollar"
        currencyTwo.symbol = "$"
        var currencyTupleArray = [CurrencyTuple]()
        var currencyTupleTwoDArray = [[CurrencyTuple]]()
        
        currencyTupleArray.append(currencyOne)
        currencyTupleArray.append(currencyTwo)
        currencyTupleTwoDArray.insert(currencyTupleArray, at: 0)
        currencyTupleTwoDArray.insert(currencyTupleArray, at: 1)
        
        let sut = viewModel.iterate(through: currencyTupleTwoDArray)
        
        XCTAssertEqual(sut[0].name, currencyTupleArray[0].name)
        XCTAssertEqual(sut[0].id, currencyTupleArray[0].id)
        XCTAssertEqual(sut[0].symbol, currencyTupleArray[0].symbol)
   
    }

    func testAddCurrenciesTwoArray() {
        mockApi.isReturningError = false
        let viewModel = DisplayViewModel(dataSource: mockApi)
        let data = ["result": CurrenciesInfo(currencyName: "British Pound", currencySymbol: "£", id: "GBP")]
        
        var currencyOne: CurrencyTuple
        currencyOne.id = "GBP"
        currencyOne.name = "British Pound"
        currencyOne.symbol = "£"
        
        var currencyTupleArray = [CurrencyTuple]()
        currencyTupleArray.insert(currencyOne, at: 0)
 
        let sut = viewModel.testAddCurrenciesTwoArray(add: data)
        
        XCTAssertEqual(sut[0].id, currencyTupleArray[0].id)
        XCTAssertEqual(sut[0].name, currencyTupleArray[0].name)
        XCTAssertEqual(sut[0].symbol, currencyTupleArray[0].symbol)
    }
}
