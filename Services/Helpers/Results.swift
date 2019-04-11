//
//  Results.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 05/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

enum Results <DataType, ErrorType: Error> {
    case success(DataType)
    case failure(ErrorType)
}
