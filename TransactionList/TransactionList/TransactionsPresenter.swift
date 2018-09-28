//
//  TransactionsPresenter.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 28/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class TransactionsPresenter {
    weak var view : TransactionViewControllerProtocol?
    var dataManager = DataManager()
    var transactions: [TransactionData]?
    
    init(view: TransactionViewControllerProtocol){
        self.view = view
        dataManager.delegate = self
        dataManager.getTransactions()
    }
    

}

extension TransactionsPresenter: LoadingDelegate{
    func dataReceived(){
        transactions = dataManager.transactionList
        view?.reloadData()
    }
    
    func dataFailed(){
        
    }
}

extension TransactionsPresenter: TransactionPresenterProtocol{
    func numberOfTransactions() -> Int{
        guard let transactions = transactions else {
            return 0
        }
        return transactions.count
    }
    
    func willShow(cell: UITableViewCell, indexPath: IndexPath) {
        guard let transactions = transactions else {
            return
            
        }
        cell.textLabel?.text = transactions[indexPath.row].description
        cell.detailTextLabel?.text = String(transactions[indexPath.row].amount.value)
    }
}
