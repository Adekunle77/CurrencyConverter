//
//  DataSourceError.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 15/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

enum DataSourceError: Error {
    case fetal(String)
    case network(Error)
    case noData
    case dataError(Error)
    case jsonParseError(Error)
}


