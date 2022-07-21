//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Арстан on 14/6/22.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager : CoinManager, coin : CoinModel)
    func didFailWithError(error : Error)
    
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "38FB78CF-9F00-465C-BDB7-2F2B17B3A1A9"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate : CoinManagerDelegate?
    func getCoinPrice (for currency : String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        
        
    }
    func performRequest(urlString: String){
        //1.create a URL
        if let url = URL(string: urlString){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
        if error != nil{
            self.delegate?.didFailWithError(error: error!)
        print(error!)
        return
        }
            if let safeData = data {
                if let coin = self.parseJSON(coinData: safeData) {
                    self.delegate?.didUpdateCoin(self, coin: coin)
                }
            }
        }
            task.resume()
        }
        //2.create a URLSession
        
        //3.Give a session a task
        //4.Stark the task
    }
    func parseJSON(coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do{
        let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let value = decodedData.asset_id_quote
            let price = decodedData.rate
            
            let coin = CoinModel(valueName: value, lastPrice: price)
          
            
            return coin
        }catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

