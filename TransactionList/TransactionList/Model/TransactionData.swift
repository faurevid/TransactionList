//
//  TransactionData.swift
//  TransactionList
//
//  Created by FAURE-VIDAL Laurene  on 27/09/2018.
//  Copyright © 2018 FAURE-VIDAL Laurene. All rights reserved.
//

import Foundation

struct GlobalData: Decodable{
    let data: [TransactionData]
}

struct TransactionData: Decodable {
    let id: String
    let date: String
    let description: String
    let categoryId: Int
    let currency: String
    let amount: AmountData
    let product: ProductData
    
    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case categoryId = "category_id"
        case currency
        case amount
        case product
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        date = try values.decode(String.self, forKey: .date)
        description = try values.decode(String.self, forKey: .description)
        categoryId = try values.decode(Int.self, forKey: .categoryId)
        currency = try values.decode(String.self, forKey: .currency)
        amount = try values.decode(AmountData.self, forKey: .amount)
        product = try values.decode(ProductData.self, forKey: .product)
    }
}

struct AmountData: Decodable {
    let value: Double
    let currencyIso: String
    
    private enum CodingKeys: String, CodingKey {
        case value
        case currencyIso = "currency_iso"
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decode(Double.self, forKey: .value)
        currencyIso = try values.decode(String.self, forKey: .currencyIso)
    }
    
    //returns the amount with the right currency
    func getAmountString() -> String{
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currencyIso
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
}

struct ProductData: Decodable{
    let id: Int
    let title: String
    let icon: String
}
