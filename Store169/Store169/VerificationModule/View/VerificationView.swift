//
//  VerificationView.swift
//  Store169
//
//  Created by Anastasiya Omak on 08/05/2024.
//

import SwiftUI
/// Экран верефикации
struct VerificationView: View {
    
    private enum Constants {
        static let continueLabel = "Continue"
        static let receiveSms = "Didn’t receive sms"
        static let sendSmsButtonLabel = "Send sms again"
        static let verificationCode = "Verification code"
        static let checkTheSMS = "Check the SMS"
        static let messageVerification = "message to get verification code"
        static let verefacitionLabel = "Verification"
        static let chevron = "chevron.left"
        static let fillLabel = "Fill in from message"
        static let okLabel = "Ok"
    }
    
    enum FieldFocusNumber: Hashable {
        case firstNumber
        case secondNumber
        case thirdNumber
        case lastNumber
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 50)
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                Image(.letter)
                                verificationCodeLabel
                                Spacer()
                                    .frame(height: 14)
                                textFieldsForCode
                                Spacer()
                                    .frame(height: 20)
                                checkSMSLabels
                                Spacer()
                                    .frame(height: 20)
                                continueButton
                                Spacer()
                                    .frame(height: 20)
                                sendSmsButton
                                Spacer()
                            }
                        }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.verefacitionLabel)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.chevron)
                }
                .tint(.white)
            }
        }
        
        .navigationBarBackButtonHidden(true)
    }
    
    @Environment(\.dismiss) private var dismiss
    @State private var numberOne = ""
    @State private var numberTwo = ""
    @State private var numberThree = ""
    @State private var numberFour = ""
    @State private var generatedCode = ""
    @State private var isShowAlert = false
    @State private var isShowProgressView = false

    @FocusState private var focused: FieldFocusNumber?
    
    private var textFieldsForCode: some View {
        HStack {
            if #available(iOS 17.0, *) {
                TextField("", text: $numberOne)
                    .modifier(TetxtFieldModifier())
                    .focused($focused, equals: .firstNumber)
                    .onChange(of: numberOne) { oldValue, newValue in
                        if newValue.count >= 1 {
                            numberOne = String(newValue.prefix(1))
                            focused = .secondNumber
                        }
                    }
            } else {
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $numberTwo)
                    .modifier(TetxtFieldModifier())
                    .focused($focused, equals: .secondNumber)
                    .onChange(of: numberTwo) { oldValue, newValue in
                        if newValue.count >= 1 {
                            numberTwo = String(newValue.prefix(1))
                            focused = .thirdNumber
                        } else if newValue == "" {
                            focused = .firstNumber
                        }
                    }
            } else {
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $numberThree)
                    .modifier(TetxtFieldModifier())
                    .focused($focused, equals: .thirdNumber)
                    .onChange(of: numberThree) { oldValue, newValue in
                        if newValue.count >= 1 {
                            numberThree = String(newValue.prefix(1))
                            focused = .lastNumber
                        } else if newValue == "" {
                            focused = .secondNumber
                        }
                    }
            } else {
            }
            if #available(iOS 17.0, *) {
                TextField("", text: $numberFour)
                    .modifier(TetxtFieldModifier())
                    .focused($focused, equals: .lastNumber)
                    .onChange(of: numberFour) { oldValue, newValue in
                        if newValue.count >= 1 {
                            numberFour = String(newValue.prefix(1))
                            focused = nil
                        } else if newValue == "" {
                            focused = .thirdNumber
                        }
                    }
            } else {
            }
        }
        
    }
    
    private var verificationCodeLabel: some View {
        Text(Constants.verificationCode)
            .font(.system(size: 20))
            .foregroundStyle(.darkGreen)
    }

    private var checkSMSLabels: some View {
        VStack(spacing: 6) {
            Text(Constants.checkTheSMS)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.darkGreen)
            VStack() {
                Text(Constants.messageVerification)
            }
            .font(.system(size: 16))
            .foregroundStyle(.darkGreen)
        }
        .padding(.horizontal, 45)
    }
    
    private var continueButton: some View {
        Button(action: {
            isShowProgressView.toggle()
        }, label: {
            if isShowProgressView {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tint(.white)
            } else {
                if #available(iOS 16.0, *) {
                    Text(Constants.continueLabel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .bold()
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                } else {
                }
            }
        })
        .frame(width: 300, height: 55)
        .background(LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                   
        )
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(color: .gray, radius: 2, x: 0.0, y: 4.0)
    }
    
    private var sendSmsButton: some View {
        VStack(spacing: 6) {
            Text(Constants.receiveSms)
                .font(.system(size: 16))
                .foregroundStyle(.darkGreen)
            if #available(iOS 16.0, *) {
                VStack() {
                    Button {
                        isShowAlert.toggle()
                    } label: {
                        Text(Constants.sendSmsButtonLabel)
                            .underline(color: .darkGreen)
                    }
                    .alert(isPresented: $isShowAlert) {
                        Alert(
                            title: Text(Constants.fillLabel),
                            message: Text(generateRandomCode()),
                            primaryButton: .default(
                                Text(Constants.okLabel),
                                action: {
                                    fillTextField(with: generatedCode)
                                }),
                            secondaryButton: .cancel()
                        )
                    }
                }
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.darkGreen)
            } else {
            }
            
        }
        .padding(.horizontal, 45)
    }
    
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            UINavigationBar.appearance().standardAppearance = appearance
        }
    
    private func generateRandomCode() -> String {
        var randomCode = ""
        for _ in 0...3 {
            randomCode += "\(Int.random(in: 0...9))"
        }
        DispatchQueue.main.async {
            generatedCode = randomCode
        }
        
        return randomCode
    }
    
    private func fillTextField(with code: String) {
        DispatchQueue.main.async {
            let characters = Array(code)
            numberOne = String(characters[0])
            numberTwo = String(characters[1])
            numberThree = String(characters[2])
            numberFour = String(characters[3])
        }
    }
    
}

#Preview {
    VerificationView()
}
