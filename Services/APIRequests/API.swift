//
//  API.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 15/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

protocol API {
    
    func fetchAPIData(endPoint: Endpoint, completion: @escaping CompletionHandler)
}
