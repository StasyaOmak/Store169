//
//  GetStartedPage.swift
//  Store169
//
//  Created by Anastasiya Omak on 07/05/2024.
//

import SwiftUI
/// Стартовый экран
struct GetStartedPage: View {
    
    private enum Constants {
        static let shopLabel = "169.ru"
        static let getStartedButtonLabel = "Get Started"
        static let doNotHaveAccountLabel = "Don't have an account?"
        static let singLabel = "Sing in here"
        static let imageLink = "https://source.unsplash.com/300x300/?furniture"
        static let questionMark = "questionmark"
        
        static let developersInfo = "Developed by Anastasiya"
        static let getStartedOffsetY = -3500.0
        static let signInOffsetY = 3500.0
    }
 
    var body: some View {
        NavigationView {
            ZStack {
                gradient
                VStack {
                    shopLabel
                    asynkImageView
//                    Image(.room)
                        .padding(.bottom, 100)
                    VStack {
                        getStartedButton
                            .padding(.bottom, 30)
                        doNotHaveAccountLabel
                            .padding(.bottom, 5)
                        signInButton
                    }
                    .onAppear(perform: {
                        withAnimation(.spring(duration: 1.5, bounce: 0.15, blendDuration: 2)) {
                            isButtonShow = true
                        }
                    })
                    
                    Divider()
                        .frame(width: 150, height: 1)
                        .overlay(.lightGreen)
                        .padding(.top, -12)
                    
                }
                developerWindow
            }
        }
    }
    
    @State private var isshowingDetail = false
    @State private var isShowMainTabBar = false
    @State private var isButtonShow = false
    @State var isDeveloperWindowShown = false
    
    private var developerWindow: some View {
        Text(Constants.developersInfo)
            .padding()
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.darkGreen))
            .opacity(isDeveloperWindowShown ? 1 : 0)
    }
    
    var longPressGesture: some Gesture {
        LongPressGesture(minimumDuration: 0.2)
            .onEnded { _ in
                withAnimation {
                    isDeveloperWindowShown = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    withAnimation {
                        isDeveloperWindowShown = false
                    }
                })
            }
    }
    
    private var gradient: some View {
        LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .bottom, endPoint: .top)
            .ignoresSafeArea()
    }
    
    private var shopLabel: some View {
        Text(Constants.shopLabel)
            .bold()
            .font(.system(size: 40))
            .foregroundStyle(.white)
    }
    
    private var getStartedButton: some View {
        Button {
            isShowMainTabBar.toggle()
        } label: {
            Text(Constants.getStartedButtonLabel)
                .bold()
                .font(.system(size: 20))
                .foregroundStyle(.linearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .top, endPoint: .bottom))
        }
        .frame(width: 300, height: 55)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(radius: 4, x: 0.0, y: 8.0)
        .fullScreenCover(isPresented: $isShowMainTabBar, content: {
            MainTabBarView()
        })
        .opacity(isButtonShow ? 1 : 0)
        .offset(y: isButtonShow ? 0 : Constants.getStartedOffsetY)
        .gesture(longPressGesture)
        
    }
    
    private var doNotHaveAccountLabel: some View {
        Text(Constants.doNotHaveAccountLabel)
            .bold()
            .font(.system(size: 16))
            .foregroundStyle(.white)
    }
    
    private var signInButton: some View {
        NavigationLink {
            LoginView()
        } label: {
            Text(Constants.singLabel)
                .bold()
                .tint(.white)
                .font(.system(size: 28))
        }
        .opacity(isButtonShow ? 1 : 0)
        .offset(y: isButtonShow ? 0 : Constants.signInOffsetY)

    }
    
    var asynkImageView: some View {
        AsyncImage(url: URL(string: Constants.imageLink)) { phase in
               switch phase {
               case .empty:
                   ProgressView()
                       .accentColor(.blue)
               case .success(let image):
                   image
                       .resizable()
                       .scaledToFill()
                       .frame(width: 300, height: 250)
                       .clipShape(Circle())
                       .cornerRadius(20 )
                       .overlay(
                           Circle()
                               .stroke(.white, lineWidth: 2)
                       )
                       .shadow(radius: 20)
                   
               case .failure(let error):
                   VStack {
                       Image(systemName: Constants.questionMark)
                       Text(error.localizedDescription)
                           .font(.headline )
                   }
               @unknown default:
                   fatalError()
                   
               }
           }
       }
}

#Preview {
    GetStartedPage()
}
