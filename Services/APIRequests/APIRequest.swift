//
//  APIRequest.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 06/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

class APIRequest: API {
    
    func fetchAPIData(endPoint: Endpoint, completion: @escaping CompletionHandler) {
        guard let url = endPoint.url else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.network(error)))
                    
            }
        }
        
        guard let data = data else {
            
            DispatchQueue.main.async {
                completion(.failure(.noData))
            }
            return
        }
        
            
            
        do {
            if endPoint.path.rawValue == Path.country.rawValue {
            if let resultJson = try self.parseCountryJson(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(.country(resultJson)))
                    }
                }
            }
            if endPoint.path.rawValue == Path.convert.rawValue {
                if let parseConvertedCurrencyJson = try self.parseConvertedCurrencyJson(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(.convert(parseConvertedCurrencyJson)))
                    }
                }
            }
            
            if endPoint.path.rawValue == Path.currencies.rawValue {
                if let parseCurrencyJson = try self.parseCurrenciesJson(data: data) {
                    DispatchQueue.main.async {
                        completion(Results.success(ModelType.currency(parseCurrencyJson)))
                    }
                }
            }
            
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.dataError(error)))
                    }
                }
            }
        task.resume()
    }
    
    fileprivate func parseCurrenciesJson(data: Data) throws -> Currencies? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode(Currencies.self, from: data) else {
            let error = DataSourceError.self
            throw error.noData
        }
        
        return parsedJson
    }
    
    
    fileprivate func parseCountryJson(data: Data) throws -> Countries? {
        let jsonDecoder = JSONDecoder()
        guard let parsedJson = try? jsonDecoder.decode(Countries.self, from: data) else {
            throw DataSourceError.noData
        }
        return parsedJson
    }
    
    fileprivate func parseConvertedCurrencyJson(data: Data) throws -> [String: Double]? {
        let jsonDecode = JSONDecoder()
        guard let parsedJson = try? jsonDecode.decode([String: Double].self, from: data) else {
            let error = DataSourceError.self
            throw error.noData
        }
    
        
        return parsedJson
    }    
}

#if DEBUG
extension APIRequest {
    
    internal func testParseCurrenciesJson(data: Data) throws-> Currencies? {
        let test = try? parseCurrenciesJson(data: data)
        return test
    }
    
    internal func testParseCountryJson(data: Data) throws -> Countries? {
        let test = try? parseCountryJson(data: data)
        return test
    }
    
    internal func testParseConvertedCurrencyJson(data: Data) throws -> [String: Double]? {
        let test = try? parseConvertedCurrencyJson(data: data)
        return test
    }

}
#endif
