//
//  TextFieldModifier.swift
//  Store169
//
//  Created by Anastasiya Omak on 08/05/2024.
//

import SwiftUI
/// настройка внешнего вида и поведения текстового поля
struct TetxtFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .textFieldStyle(.roundedBorder)
        .font(.system(size: 40))
        .frame(width: 60)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
    }
}
