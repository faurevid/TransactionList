//
//  TransactionsProtocol.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene  on 28/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

protocol TransactionViewControllerProtocol : class {
    func reloadData()
    func displayError(error: Error)
    func displayNetworkError()
}

protocol TransactionPresenterProtocol : class {
    func didAppear()
    func numberOfSections() -> Int
    func titleForSection(forSection: Int) -> String
    func numberOfTransactions(forSection: Int) -> Int
    func willShow(cell: TransactionCell, indexPath: IndexPath)
    func retryLoading()
}

protocol LoadingDelegate {
    func dataReceived()
    func dataFailed(error: Error)
}
