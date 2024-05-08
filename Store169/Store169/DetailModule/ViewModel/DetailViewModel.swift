//
//  DetailViewModel.swift
//  Store169
//
//  Created by Anastasiya Omak on 07/05/2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    
    enum Constants {
        static let titleLabel = "Sofa Elda 900"
        static let imageName = "couch"
        static let priceLabel = 999
        static let articleNumberLabel = 283564
        static let descriptionFullLabel = "A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design."
        
    }
    
    public var furniture: [Furniture] = [Furniture(name: Constants.titleLabel, imageName: Constants.imageName, price: Constants.priceLabel, article: Constants.articleNumberLabel, description: Constants.descriptionFullLabel)]
    
}
    
   
