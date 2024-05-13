//
//  PaymentView.swift
//  Store169
//
//  Created by Anastasiya Omak on 13/05/2024.
//

import SwiftUI

struct PaymentView: View {
    
    private enum Constants {
        static let cartAddLabel =  "Карта добавлена"
        static let numberInputLabel = "Введите 3 цифры"
        static let cvcLabel = "***"
        static let eyeSlashImage = "eye.slash"
        static let eyeImage = "eye"
        static let backButton = "chevron.backward"
        static let headingTitle = "Payment"
        static let addButtonTitle = "Add now"
        static let cardNum = "Card number"
        static let fullName = "Your Name"
        static let cardHolder = "Cardholder"
        static let holderName = "Cardholder Name"
        static let defaultCardNum = "0000 0000 0000 0000"
        static let cardNumPlaceholder = "**** **** **** 0000"
        static let cardNumberPlaceholder = "**** **** **** "
        static let maxNumLength = 16
        static let addCardButton = "Add new card"
        static let expirationMonth = "Month"
        static let expirationYear = "Year"
        static let experationDate = "Date"
        static let securityCode = "CVC"
        static let securityCodePrompt = "000"
        static let securityCodeCVV = "CVC/CVV"
        static let cardValidity = "Valid"
        static let gradientSize = 118.0
        static let animationSpeed = 0.3
    }
    
    @State var isPasswordHidden = true
    @State var holderName = ""
    @State var cardNum = ""
    @State var month = "1"
    @State var year = "2024"
    @State var securityCode = ""
    @State var frontRotation = 0.0
    @State var backRotation = 90.0
    @State var isCardFlipped = false
    @State var isSecurityAlertShown = false
    @State var isSuccessAlertDisplayed = false
    
    var body: some View {
            VStack {
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                    .frame(height: 100)
                    .ignoresSafeArea(edges: .top)
            }
            VStack {
                Spacer()
                    .frame(height: 50)
                        ScrollView {
                            ZStack {
                                cardFrontSide
                                cardBackSide
                            }
                            .onTapGesture {
                                flipCard()
                            }
                            enterCardDetail
                            enterDateDetail
                            cvcHolderView
                        }
                        .padding(.top, -70)
                        Spacer()
                        addButton
        }
    }
    
    private var cardFrontSide: some View {
        VStack(alignment: .leading) {
            ZStack {
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 30)
                    .shadow(radius: 2, y: 2)
                VStack(alignment: .leading) {
                    Image(.mirLabel)
                        .padding(.leading, 230)
                    Group {
                        Text(cardNumberPlaceholder)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.cardNum)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                        Spacer()
                            .frame(height: 20)
                        Text(Constants.fullName)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(cardhPlaceholder)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    .padding(.trailing, 100)
                }
            }
        }
        .rotation3DEffect(
            Angle(degrees: frontRotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardBackSide: some View {
        ZStack {
            LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 30)
                .shadow(radius: 3, y: 3)
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    Text(cardNumberBackPlaceholder)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                    HStack {
                        Text(cvcPlaceholder)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.securityCodeCVV)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                    HStack {
                        Text(dateInput)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                        Text(Constants.cardValidity)
                            .foregroundStyle(.white)
                            .font(.system(size: 16))
                    }
                }
                .padding(.trailing, 50)
            }
        }
        .rotation3DEffect(
            Angle(degrees: backRotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private var cardNumberPlaceholder: String {
        if cardNum.count == 16 {
            let lastSymbols = String(cardNum.suffix(4))
            return Constants.cardNumberPlaceholder + lastSymbols
        } else {
            return Constants.cardNumPlaceholder
        }
    }
    
    private var cardhPlaceholder: String {
        holderName.isEmpty ? Constants.cardHolder : holderName
    }
    
    private var cvcPlaceholder: String {
        securityCode.count == Constants.securityCodePrompt.count ? securityCode : Constants.securityCodePrompt
    }
    
    private func flipCard() {
        isCardFlipped.toggle()
        if isCardFlipped {
            withAnimation(.linear(duration: 0.3)) {
                frontRotation = -90
                withAnimation(.linear(duration: 0.3).delay(0.3)){
                    backRotation = 0
                }
            }
        } else {
            withAnimation(.linear(duration: 0.3).delay(0.3)){
                frontRotation = 0
            }
            withAnimation(.linear(duration: 0.3)) {
                backRotation = 90
            }
        }
    }
    
    private var enterCardDetail: some View {
        VStack(alignment: .leading) {
            Text(Constants.addCardButton)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.darkGreen)
            TextField("", text: $holderName, prompt: Text(Constants.holderName))
            .foregroundStyle(.darkGreen)
            .font(.system(size: 20))
            Divider()
            Text(Constants.cardNum)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.darkGreen)
            if #available(iOS 17.0, *) {
                TextField("", text: $cardNum, prompt: Text(Constants.defaultCardNum))
                    .foregroundStyle(.darkGreen)
                    .font(.system(size: 20))
                    .keyboardType(.decimalPad)
                    .onChange(of: cardNum) { oldValue, _ in
                        if cardNum.count > Constants.maxNumLength {
                            cardNum = oldValue
                        }
                    }
            }
            Divider()
        }
        .padding()
    }
    
    private var enterDateDetail: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(Constants.experationDate)
                        .font(.system(size: 20))
                    Picker(selection: $month) {
                        ForEach (1...12, id: \.self) {Text("\($0)").tag("\($0)")}
                    } label: {
                        Text("")
                            .foregroundStyle(.darkGreen)
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
            VStack(alignment: .leading) {
                HStack {
                    Text("Year")
                        .font(.system(size: 20))
                    Picker(selection: $year) {
                        ForEach (0...10, id: \.self) {Text(String(2024 + $0)).tag(String(2024 + $0))}
                    } label: {
                        Text(Constants.expirationYear)
                    }
                    .pickerStyle(.menu)
                }
                Divider()
            }
            .padding(.trailing, 40)
        }
        .tint(.darkGreen)
        .padding(.horizontal)
    }
    
    private var dateInput: String {
        let monthInteger = Int(month) ?? 0
        return String(format: "%02d", monthInteger) + "/" + String(year.suffix(2))
    }
    
    private var cardNumberBackPlaceholder: String {
        cardNum.count == 16 ? cardNum : Constants.defaultCardNum
    }
    
    private var cvcHolderView: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("CVC")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(.darkGreen)
            HStack {
                if #available(iOS 17.0, *) {
                    if isPasswordHidden {
                        SecureField(Constants.cvcLabel, text: $securityCode)
                            .font(.system(size: 20))
                            .foregroundStyle(.darkGreen)
                            .keyboardType(.decimalPad)
                            .onChange(of: securityCode) { oldValue, _ in
                                if securityCode.count == 4 {
                                    securityCode = oldValue
                                }
                            }
                    } else {
                        TextField(Constants.cvcLabel, text: $securityCode)
                            .font(.system(size: 20))
                            .foregroundStyle(.darkGreen)
                            .keyboardType(.decimalPad)
                            .onChange(of: securityCode) { oldValue, _ in
                                if securityCode.count == 4 {
                                    securityCode = oldValue
                                }
                            }
                    }
                    Button(action: {
                        isPasswordHidden.toggle()
                    }){
                        Image(systemName: isPasswordHidden ? Constants.eyeSlashImage : Constants.eyeImage)
                            .foregroundStyle(.darkGreen)
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
    
    private var addButton: some View {
        Button {
            addAction()
        }
    label: {
        Text(Constants.addButtonTitle)
            .padding(.vertical, 20)
            .padding(.horizontal, 120)
            .font(.title2.bold())
            .background(
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
            )
            .foregroundStyle(.white)
    }
    .cornerRadius(27)
    .shadow(color: .gray, radius: 2, x: 0.0, y: 3.0)
    .padding(.bottom, 20)
    .alert(Constants.cartAddLabel, isPresented: $isSuccessAlertDisplayed, actions: {})
    .alert(Constants.numberInputLabel, isPresented: $isSecurityAlertShown, actions: {})
    }
    
    private func addAction() {
        if securityCode.count == 3 {
            isSuccessAlertDisplayed = true
        } else { isSecurityAlertShown = true}
    }
}
#Preview {
    PaymentView()
}
