//
//  ProductDetails.swift
//  Store169
//
//  Created by Anastasiya Omak on 07/05/2024.
//

import SwiftUI
/// Экран отображения товара 
struct ProductDetails: View {

    private enum Constants {
        static let priceNameLabel = "Price: "
        static let buyNowLabel = "Buy Now"
        static let articleLabel = "Article:"
        static let descriptionNameLabel = "Description: "
        static let reviewLabel = "Review"
    }
    
    @Environment(\.presentationMode) var presentationMode
    @State var text = ""
    @State var totalChars = 0
    @State var lastText = ""
    
    var body: some View {
            VStack{
                
                nameLabel
                productPicture
                priceLabel
                    .padding()
                ZStack {
                    foreground
                    VStack(spacing: 15) {
                        HStack {
                            articleLabel
                            articleNumberLabel
                        }
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.trailing, 220)
                        descriptionLabel
                            .padding(.horizontal)
                            .frame(width: UIScreen.main.bounds.width)
                        reviewLabel
                        textEditor
                        buyNowButton
                    }
                    .padding()
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
    
    @ObservedObject private var viewModel = DetailViewModel()
    
    private var textEditor: some View {
        HStack {
            if #available(iOS 16.0, *) {
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.white)
                    .frame(width: 250, height: 150)
                    .onChange(of: text, perform: { text in
                        totalChars = text.count
                        if totalChars <= 300 {
                            lastText = text
                        } else {
                            self.text = lastText
                        }
                    })
            } else {
            }
            
            Text("\(totalChars) / 300")
                        .foregroundColor(.white)
                        .padding(.bottom,100)
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.horizontal)
    }
    
    private var nameLabel: some View {
        HStack {
            Text(viewModel.furniture[0].name)
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(.detailLabel)
               
        Spacer()
            Button {
                
            } label: {
                Image(.favorite)
            }
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width)
    }

    private var productPicture: some View {
        Image(viewModel.furniture[0].imageName)
    }
    
    private var priceLabel: some View {
        Text("\(Constants.priceNameLabel)\(viewModel.furniture[0].price) $")
            .fontWeight(.heavy)
            .font(.system(size: 24))
            .foregroundStyle(.detailLabel)
            .padding()
            .frame(width: 300, height: 55, alignment: .leading)
            .background(.priceLabel)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .circular))
            .shadow(radius: 4, x: 0.0, y: 8.0)
            .padding(.leading, 300)
    }
    
    private var foreground: some View {
        RoundedRectangle(cornerRadius: 16.0, style: .circular)
            .foregroundStyle(.linearGradient(colors: [.darkGreen, .darkGreen.opacity(0.3)], startPoint: .bottom, endPoint: .top))
            .frame(maxWidth: 400, maxHeight: 600)
            .ignoresSafeArea()
    }
    
    private var buyNowButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(Constants.buyNowLabel)
                .bold()
                .font(.system(size: 20))
                .foregroundStyle(.linearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .top, endPoint: .bottom))
        }
        .frame(width: 300, height: 55)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 27))
        .shadow(radius: 4, x: 0.0, y: 8.0)
    }
    
    private var articleLabel: some View {
        Text("\(Constants.articleLabel)")
            .fontWeight(.heavy)
            .font(.system(size: 16))
            .foregroundStyle(.white)
    }
    
    private var articleNumberLabel: some View {
        Text("\(viewModel.furniture[0].article)")
            .font(.system(size: 16))
            .foregroundStyle(.white)
    }
    
    private var descriptionLabel: some View {
        HStack {
            Text(Constants.descriptionNameLabel)
                .fontWeight(.heavy)
            +
            Text("\(viewModel.furniture[0].description)")
                .font(.system(size: 16))
        }
        .foregroundStyle(.white)
    }
    
    private var reviewLabel: some View {
        Text(Constants.reviewLabel)
            .fontWeight(.heavy)
            .font(.system(size: 16))
            .foregroundStyle(.white)
    }
    
}

#Preview {
    ProductDetails()
}
