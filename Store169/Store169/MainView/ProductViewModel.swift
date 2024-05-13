//
//  ProductViewModel.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import Foundation
///modelView товара 
class ProductViewModel: ObservableObject {
    
    @Published var totalPrice = 0
    
    @Published var products: [Product] = [
        Product(name: "Sofa", imageName: "sofa", price: "2000", newPrice: 999),
        Product(name: "Armchair", imageName: "armchair", price: "200", newPrice: 99),
        Product(name: "Bed", imageName: "bed", price: "2000", newPrice: 1000),
        Product(name: "Table", imageName: "table", price: "1200", newPrice: 600),
        Product(name: "Сhair", imageName: "chair", price: "200", newPrice: 99),
        Product(name: "Wardrobe", imageName: "wardrobe", price: "1100", newPrice: 899)
    ]
    
    func updateTotalPrice(id: UUID, change: PriceChange) {
        if let index = products.firstIndex(where: { $0.id == id }) {
            switch change {
            case .plus:
               products[index].count += 1
            case .minus:
                if products[index].count > 0 {
                    products[index].count -= 1
                }
            }
            totalPrice = 0
            
            for product in products {
                totalPrice += product.newPrice * product.count
            }
        }
    }
    
}

enum PriceChange {
    case plus
    case minus
}

