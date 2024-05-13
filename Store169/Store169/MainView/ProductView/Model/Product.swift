//
//  Product.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import Foundation

/// Настройка
struct Product: Hashable {
    /// Наименование
    let name: String
    /// Картинка
    let imageName: String
    /// Цена
    let price: String
    /// Новая цена
    var newPrice: Int
    /// идентификатор для продукта
    var id = UUID()
    /// количество данного товара в корзине
    var count = 0
}
