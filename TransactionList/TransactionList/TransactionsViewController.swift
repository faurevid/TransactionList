//
//  TransactionsViewController.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene (Prestataire)  [IT-CE] on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class TransactionViewController : UIViewController {
    @IBOutlet weak var transactionsTableView: UITableView!
    weak var presenter: TransactionPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TransactionsPresenter(view: self)
    }
}

extension TransactionViewController :  TransactionViewControllerProtocol{
    func reloadData() {
        transactionsTableView.reloadData()
    }
}

extension TransactionViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.numberOfSections())!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForSection(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfTransactions(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? UITableViewCell else{
            return UITableViewCell()
        }
       presenter?.willShow(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
}
