
//
//  DisplayViewModel.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 09/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelDelegate: class {
    func modelDidUpdateData()
    func modelDidUpdateWithError(error: Error)
}

typealias CurrencyTuple = (name: String, id: String, symbol:String)

class DisplayViewModel {
    
    // MARK: - Properties
    var currenciesTwoDArray = [[String: CurrenciesInfo]]()
    var currenciesTuple = [[CurrencyTuple]]()
    
    var delegate: ViewModelDelegate?
    var dataSource: API
    var convertedRate = [String: Double]()
    
    init(dataSource: API) {
        self.dataSource = dataSource
    }

    // MARK: - API Request Methods
    func fetchCurrencies() {
        dataSource.fetchAPIData(endPoint: .currencies(), completion: { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.modelDidUpdateWithError(error: error)
            case Results.success(let data):
                switch data {
                case .currency(let data):

                guard let currencyArray = self?.addCurrenciesTwoArray(add: data.results) else {return}
 
                // 2D array for the 2x pickerView
                self?.currenciesTuple.insert(currencyArray, at: 0)
                self?.currenciesTuple.insert(currencyArray, at: 1)

                    break
                default:
                    break
                }
                self?.delegate?.modelDidUpdateData()
            }
        })
    }
    
    
    func convert(currencies: String) {
        dataSource.fetchAPIData(endPoint: .convert(currencies: currencies), completion: { [weak self] results in
            switch results {
            case .failure(let error):
                self?.delegate?.modelDidUpdateWithError(error: error)
            case .success(let data):
                switch data {
                case .convert(let convertedData):
                    self?.convertedRate = convertedData
                    self?.delegate?.modelDidUpdateData()
                    break
                default:
                    break
                }
            }
        })
    }
    
    
    // MARK: - DisplayViewController Helper Methods
    func joinCurrencies(with: CurrencyTuple, and: CurrencyTuple) -> String {
        let currencies = "\(with.1)" + "_" + "\(and.1)"
        
        return currencies
    }
    
    
    func iterate(through twoDArray: [[CurrencyTuple]]) -> [CurrencyTuple] {
        var currencyArray = [CurrencyTuple]()
        
        twoDArray.forEach { array in
           currencyArray = array
        }
        return currencyArray
        
        
    }

    // MARK: - Private Methods
    private func addCurrenciesTwoArray(add: [String: CurrenciesInfo]) -> [CurrencyTuple] {
        
        var tupleArray = [CurrencyTuple]()
        
        for (_, value) in add {
            var currenciesTuple: CurrencyTuple
            currenciesTuple.0 = value.currencyName ?? "Not available"
            currenciesTuple.1 = value.id ?? "Not available"
            currenciesTuple.2 = value.currencySymbol ?? "Not available"
            tupleArray.append(currenciesTuple)

        }
        return tupleArray
    }

}


#if DEBUG
extension DisplayViewModel {
    func testAddCurrenciesTwoArray(add: [String: CurrenciesInfo]) -> [CurrencyTuple] {
        let test = addCurrenciesTwoArray(add: add)
        return test
    }

}
#endif
