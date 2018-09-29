//
//  DataManager.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation



class DataManager {
    var transactionList : [TransactionData] = []
    var delegate: LoadingDelegate?
    static let urlString = "http://www.mocky.io/v2/5b33bdb43200008f0ad1e256"
    
    func getTransactions() {
        guard let url = URL(string: DataManager.urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do{
               let transactions = try JSONDecoder().decode(GlobalData.self, from: data)
                self.transactionList = transactions.data
                
                DispatchQueue.main.async {
                    self.delegate?.dataReceived()
                }
            }
            catch let jsonError {
                print("Error serializing json", jsonError)
                self.delegate?.dataFailed(error: jsonError)
            }
        }.resume()
    }
}
