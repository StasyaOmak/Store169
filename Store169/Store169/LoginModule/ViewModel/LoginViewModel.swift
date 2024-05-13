//
//  LoginViewModel.swift
//  Store169
//
//  Created by Anastasiya Omak on 08/05/2024.
//

import Foundation

/// Вью модель экрана логин
final class LoginViewModel: ObservableObject {

    @Published var isPasswordHidden = true

    let phoneMask = "+X(XXX)XXX-XX-XX"

    func format(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in phoneMask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
