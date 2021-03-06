//
//  TransactionsViewController.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene  on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation
import UIKit

class TransactionViewController : UIViewController {
    @IBOutlet weak var transactionsTableView: UITableView!
    weak var presenter: TransactionPresenterProtocol?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TransactionsPresenter(view: self)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: transactionsTableView.frame.size.width, height: 40))
        headerView.backgroundColor = UIColor(red: 92/255, green: 175/255, blue: 221/255, alpha: 1)
        let headerLabel = UILabel(frame: headerView.frame)
        headerLabel.text = "Transactions"
        headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 30)
        headerLabel.textAlignment = .center
        headerLabel.textColor = UIColor(red: 92/255, green: 94/255, blue: 109/255, alpha: 1)
        headerView.addSubview(headerLabel)
        transactionsTableView.tableHeaderView = headerView
        transactionsTableView.layer.cornerRadius = 10
        
        transactionsTableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.didAppear()
    }
}

//MARK: TransactionViewControllerProtocol
extension TransactionViewController :  TransactionViewControllerProtocol{
    func reloadData() {
        transactionsTableView.reloadData()
    }
    
    //MARK: Error handling
    func displayError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default, handler: {(alert: UIAlertAction!) in self.presenter?.retryLoading()})
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
    
    func displayNetworkError() {
        let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default, handler: {(alert: UIAlertAction!) in self.presenter?.retryLoading()})
        alertController.addAction(action)
        
        self.present(alertController, animated: true)
    }
}

//MARK: TableView management
extension TransactionViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.numberOfSections())!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForSection(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 21))
        header.backgroundColor = UIColor(red: 92/255, green: 94/255, blue: 109/255, alpha: 1)
        let hLabel = UILabel(frame: CGRect(x: 10, y: 3, width: tableView.frame.size.width - 20, height: 21))
        hLabel.textColor = UIColor.white
        hLabel.text = presenter?.titleForSection(forSection: section)
        hLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        header.addSubview(hLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfTransactions(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as? TransactionCell else{
            return UITableViewCell()
        }
       presenter?.willShow(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
}
