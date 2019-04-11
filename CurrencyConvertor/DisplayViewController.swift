//
//  DisplayViewController.swift
//  CurrencyConvertor
//
//  Created by Ade Adegoke on 05/03/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

class DisplayView: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak private var exchangedFrom: UILabel!
    @IBOutlet weak private var exchangedTo: UILabel!
    @IBOutlet weak private var convertPickerView: UIPickerView!
    @IBOutlet weak private var convertedRate: UILabel!
    @IBOutlet weak private var enterAmount: UITextField!
    private var viewModel: DisplayViewModel!

    private var firstCurreny: CurrencyTuple?
    private var secondCurreny: CurrencyTuple?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertPickerView.delegate = self
        viewModelSetUp()
        enterAmount.delegate = self
        enterAmount.keyboardType = .asciiCapableNumberPad
        
    }
    
    // MARK: - View Set up
    private func pickerViewSetUp() {
    }
    
    
    private func textFieldSetUp() {
        exchangedFrom.text = firstCurreny?.name
    }
    
    private func viewModelSetUp() {
        let dataSource = APIRequest()
        viewModel = DisplayViewModel(dataSource: dataSource)
        viewModel.delegate = self
        viewModel.fetchCurrencies()
    }
}


//TODO: -  Extensions

extension DisplayView: UITextFieldDelegate {}

extension DisplayView: ViewModelDelegate {
    func modelDidUpdateData() {
        self.convertPickerView.reloadAllComponents()
        guard let amount = Double(enterAmount.text ?? "1") else { return }
        viewModel.convertedRate.forEach { convertedRate.text = String(amount * $0.value) }
    }
    func modelDidUpdateWithError(error: Error) {
        print(error)
    }
}

extension DisplayView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.currenciesTuple.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currenciesTuple[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let currenciesTuples = viewModel.currenciesTuple
        let pickerViewTitles = viewModel.iterate(through: currenciesTuples)
        return pickerViewTitles[row].name
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currenciesTuples = viewModel.currenciesTuple
        let pickerViewTitles = viewModel.iterate(through: currenciesTuples)

        let currencyOne = pickerViewTitles[pickerView.selectedRow(inComponent: 0)]
        let currencyTwo = pickerViewTitles[pickerView.selectedRow(inComponent: 1)]
        exchangedFrom.text = "Exchange From: \(currencyOne.name)"
        exchangedTo.text = "Exchange to: \(currencyTwo.name)"
        firstCurreny = currencyOne
        secondCurreny = currencyTwo
        
        let joinedCurrencies = viewModel.joinCurrencies(with: currencyOne, and: currencyTwo)
        viewModel.convert(currencies: joinedCurrencies)
        
        guard let amount = Double(enterAmount.text ?? "1") else { return }

        viewModel.convertedRate.forEach { convertedRate.text = String(amount * $0.value) }

    }
}


