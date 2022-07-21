//
//  ViewController.swift
//  ByteCoin
//
//  Created by Арстан on 14/6/22.

//

import UIKit

class CoinViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate,CoinManagerDelegate {
    var coinManager = CoinManager()
    
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didUpdateCoin(_ coinManager : CoinManager, coin : CoinModel){
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.priceString
            self.currencyLabel.text = coin.valueName
        
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
