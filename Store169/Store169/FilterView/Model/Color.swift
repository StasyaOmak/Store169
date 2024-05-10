//
//  Color.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI
/// Шаблон цвета
struct ColorSample: Identifiable {
    // название цвета
    let colorName: String
    // цвет примера
    let color: Color
    /// идентификатор для цвета
    var id = UUID()
}
