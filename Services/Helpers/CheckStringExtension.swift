//
//  CheckStringExtension.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 28/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import Foundation

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
