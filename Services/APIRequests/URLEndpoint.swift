//
//  URLEndpoint.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 06/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: Path
    let queryItems: [URLQueryItem]
}

enum Path: String {
    case convert = "/api/v6/convert"
    case country = "/api/v6/countries"
    case currencies = "/api/v6/currencies"
}

extension Endpoint {
    static func convert(currencies query: String) -> Endpoint {
        return Endpoint(
            path: .convert,
            queryItems: [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "compact", value: "ultra"),
                URLQueryItem(name: "apiKey", value: "fe49ce3446ac2d67d7c2"),
                
                ]
            )
    }
}

extension Endpoint {
    static func country() -> Endpoint {
        return Endpoint(
            path: .country,
            queryItems: [
                URLQueryItem(name: "apiKey", value: "fe49ce3446ac2d67d7c2"),
            ]
        )
    }
}


extension Endpoint {
    static func currencies() -> Endpoint {
        return Endpoint(
            path: .currencies,
            queryItems: [
                URLQueryItem(name: "apiKey", value: "fe49ce3446ac2d67d7c2"),
                ]
        )
    }
}


extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "free.currencyconverterapi.com"
        components.path = path.rawValue
        components.queryItems = queryItems
        return components.url
    }
}

