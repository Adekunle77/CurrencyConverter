//
//  ModelType.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 06/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

enum ModelType {
    case country(Countries)
    case currency(Currencies)
    case convert([String: Double])
}



