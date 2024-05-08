//
//  LoginView.swift
//  Store169
//
//  Created by Anastasiya Omak on 08/05/2024.
//

import SwiftUI

/// Экран авторизации
struct LoginView: View {
    
    private struct Constants {
        static let password = "Password"
        static let forgotPassword = "Forgot your password?"
        static let helpPhoneLabel = "Телефон поддержки"
        static let helpPhoneNumber = "+7 (495) 937-99-92"
        static let signUp = "Sing up"
        static let phoneNumberTextfield = "+ *(***)***-**-**"
        static let symbols = "••••••••"
        static let eyeClose = "eye.slash"
        static let eyeOpen = "eye"
        static let checkVerificationLabel = "Check Verification"
        static let error = "Ошибка"
        static let makePassword = "Пароль должен быть больше 6 символов"
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = LoginViewModel()
    @State var totalPasswordChars = 0
    @State var lastPasswordText = ""
    @FocusState var isPhoneFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 1)
                mainView
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(
                VStack {
                    LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                }
                    .ignoresSafeArea(.all, edges: .all)
                
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .tint(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @State private var phoneNumberText = ""
    @State private var passwordText = ""
    @State private var isForgotAlertShow = false
    @State private var isPasswordAlertShow = false
    
    private var mainView: some View {
        VStack {
            Spacer()
                .frame(height: 37)
            pickerView
            Spacer()
                .frame(height: 78)
            phoneTextFieldView
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 24)
            Text(Constants.password)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .padding(.trailing, 280)
                .foregroundStyle(.darkGreen)
            passwordTextFieldView
            Divider()
                .frame(maxHeight: 1)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            Spacer()
                .frame(height: 111)
            signUpButtonView
            Spacer()
                .frame(height: 24)
            Button(action: {
                isForgotAlertShow = true
            }) {
                Text(Constants.forgotPassword)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.darkGreen)
            }
            .alert(Constants.helpPhoneLabel, isPresented: $isForgotAlertShow, actions: {
            }, message: {
                Text(Constants.helpPhoneNumber)
            })
            Spacer()
                .frame(height: 18)
            checkVerificationView
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    private var pickerView: some View {
        HStack(spacing: 0) {
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 27.0,
                    bottomLeading: 27.0,
                    bottomTrailing: 0,
                    topTrailing: 0),
                                       style: .continuous)
                .stroke(.loginGray, lineWidth: 2)
                .frame(width: 150, height: 51)
                .overlay {
                    Text("Log in")
                        .foregroundStyle(
                            LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .bottom, endPoint: .top)
                        )
                        .font(.title2.bold())
                }
            } else {
                // Fallback on earlier versions
            }
            
            if #available(iOS 16.0, *) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: 27.0,
                    topTrailing: 27.0),
                                       style: .continuous)
                .frame(width: 150, height: 53)
                .foregroundStyle(.loginGray)
                .overlay {
                    Text(Constants.signUp)
                        .foregroundStyle(
                            LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .bottom, endPoint: .top)
                        )
                        .font(.title2.bold())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }

    private var phoneTextFieldView: some View {
        TextField(Constants.phoneNumberTextfield, text: $phoneNumberText)
            .font(.title2)
            .onChange(of: phoneNumberText) { text in
                phoneNumberText = viewModel.format(phone: text)
            }
            .keyboardType(.phonePad)
            .textContentType(.telephoneNumber)
            .focused($isPhoneFocused)
    }
    
    private var passwordTextFieldView: some View {
        
        HStack {
            Group {
                if viewModel.isPasswordHidden {
                    SecureField(Constants.symbols, text: $passwordText)
                        .font(.title2.bold())
                } else {
                    TextField(Constants.symbols, text: $passwordText)
                        .font(.title2.bold())
                }
            }
            .focused($isPasswordFocused)
            .onChange(of: passwordText) { text in
                totalPasswordChars = text.count
                if totalPasswordChars <= 15 {
                    lastPasswordText = text
                } else {
                    passwordText = lastPasswordText
                    isPasswordFocused = false
                }
            }
            Button(action: {
                viewModel.isPasswordHidden.toggle()
            }){
                Image(systemName: viewModel.isPasswordHidden ? Constants.eyeClose : Constants.eyeOpen)
                    .foregroundStyle(.darkGreen)
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        
    }
    
    private var signUpButtonView: some View {
        Button(action: {
            showingDetail.toggle()
        }) {
            Text(Constants.signUp)
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding()
                .frame(width: 300, height: 55)
                .background(
                    RoundedRectangle(cornerRadius: 27)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.darkGreen, .darkGreen.opacity(0.2)]),
                                startPoint: .trailing,
                                endPoint: .leading
                            )
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 27))
                .shadow(radius: 4, x: 0.0, y: 8.0)
        }
        .fullScreenCover(isPresented: $showingDetail, content: {
            ProductDetails()
        })
    }
    
    private var checkVerificationView: some View {
        VStack {
            NavigationLink {
                VerificationView()
            } label: {
                Text(Constants.checkVerificationLabel)
                    .font(.system(size: 20).bold())
                    .foregroundStyle(.darkGreen)
                    .padding(.bottom, 5)
                    .alert(Constants.error, isPresented: $isPasswordAlertShow, actions: {
                    }, message: {
                        Text(Constants.makePassword)
                    })
            }
            Divider()
                .frame(width: 160, height: 1)
        }
    }
}

#Preview {
    LoginView()
}
