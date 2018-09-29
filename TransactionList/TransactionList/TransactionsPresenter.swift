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
    var dates = [Date]()
    var transactions: [TransactionData]?
    var transactionsByDate = [Date : [TransactionData]]()
    let dateFormatter = DateFormatter()
    let imageCache2 = NSCache<NSString, UIImage>()
    
    init(view: TransactionViewControllerProtocol){
        self.view = view
        dataManager.delegate = self
        dataManager.getTransactions()
    }

}

extension TransactionsPresenter: LoadingDelegate{
    func dataReceived(){
        transactions = dataManager.transactionList
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for item in transactions!{
            let date = dateFormatter.date(from: item.date)
            if (transactionsByDate.keys.contains(date!)){
                transactionsByDate[date!]?.append(item)
            }
            else{
                transactionsByDate.updateValue([item], forKey: date!)
            }
        }
        dates = transactionsByDate.keys.sorted(by: {$0 < $1})
       
        view?.reloadData()
    }
    
    func dataFailed(){
        
    }
}

extension TransactionsPresenter: TransactionPresenterProtocol{
    func numberOfSections() -> Int{
        return transactionsByDate.keys.count
    }
    
    func titleForSection(forSection: Int) -> String{
        let date = dates[forSection]
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func numberOfTransactions(forSection: Int) -> Int{
        let date =  dates[forSection]
        return transactionsByDate[date]!.count
    }
    
    func willShow(cell: TransactionCell, indexPath: IndexPath) {
        let date = dates[indexPath.section]
        let transaction = transactionsByDate[date]![indexPath.row]
        cell.transactionTitle?.text = transaction.description
        cell.transactionAmout?.text =  transaction.amount.getAmountString()
        cell.productIcon.cacheImage(urlString: transaction.product.icon)
    }
    
    
 
}
