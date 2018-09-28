//
//  TransactionsProtocol.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 28/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

protocol TransactionViewControllerProtocol : class {
    func reloadData()
}

protocol TransactionPresenterProtocol : class {
    func numberOfTransactions() -> Int
    func willShow(cell: UITableViewCell, indexPath: IndexPath)
}

protocol LoadingDelegate {
    func dataReceived()
    func dataFailed()
}
