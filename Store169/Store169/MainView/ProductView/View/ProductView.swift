//
//  ProductView.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI
///экран отображения товаров 
struct ProductView: View {
    
    private enum Constants {
        static let searchPlaceHolder = "Search..."
        static let priceLabel = "Your total price "
        static let minus = "-"
        static let plus = "+"
        
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    searchBar
                    Rectangle()
                        .fill(.white)
                        .ignoresSafeArea()
                        .overlay {
                            VStack {
                                Spacer()
                                    .frame(height: 20)
                                productTotalPrice
                                scrollView
                            }
                        }
                }
            }
        }
    }
    
    @ObservedObject private var productViewModel = ProductViewModel()
    @State private var isshowingDetail = false
    @State private var search = ""
    
    private var searchBar: some View {
        HStack() {
            HStack() {
                Group() {
                    Image(.magnifyingglass)
                    TextField(Constants.searchPlaceHolder, text: $search)
                        .padding(.leading, -20)
                }
                .padding( 10)
            }
            .background()
            .clipShape(.rect(cornerRadius: 24))
            .frame(width: 312, height: 48)
            .padding(.leading, 20)
            NavigationLink {
               FilterView()
            } label: {
                Image(.filter)
            }
        }
    }

    private var productTotalPrice: some View {
        HStack {
            Text("\(Constants.priceLabel) \(productViewModel.totalPrice)$ ")
                .fontWeight(.heavy)
                .font(.system(size: 20))
                .foregroundStyle(.detailLabel)
                .padding(.vertical, 10)
                .padding(.horizontal, 25)
                .background(.lightGreen)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .offset(x: 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var scrollView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(productViewModel.products, id: \.name) { product in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.backgroundGreen)
                            .frame(height: 150)
                            .shadow(radius: 2, x: 0.0, y: 4.0)
                            .padding(.horizontal, 15)
                        setupProductCellView(product: product)
                            .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
    
    private func setupProductCellView(product: Product) -> some View {
        HStack() {
            Button(action: {
                isshowingDetail.toggle()
            }, label: {
                Image(product.imageName)
                    .resizable()
                    .frame(width: 140, height: 140)
                Spacer().frame(width: 50)
            })
            .fullScreenCover(isPresented: $isshowingDetail, content: {
                ProductDetails()
            })
            VStack {
                Text(product.name)
                    .font(.system(size: 20, weight: .heavy))
                    .foregroundStyle(.detailLabel)
                HStack() {
                    Text("\(product.newPrice)$")
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundStyle(.lightGreen)
                    Text("\(product.price)$")
                        .font(.system(size: 20))
                        .strikethrough(true, color: .detailLabel)
                }
                backingView(for: product)
            }
        }
        .foregroundStyle(.detailLabel)
    }
    
    private func backingView(for product: Product) -> some View {
        ZStack {
            Color.stepperBackground
                .frame(width: 115, height: 40)
                .cornerRadius(24)
            HStack(spacing: 12) {
                Button {
                    if product.count > 0 {
                        productViewModel.updateTotalPrice(id: product.id, change: .minus)
                    }
                } label: {
                    Text(Constants.minus)
                        .font(.system(size: 18))
                        .bold()
                }
                
                Text("\(product.count)")
                    .font(.system(size: 18))
                    .bold()
                    .frame(width: 40)
                
                Button {
                    productViewModel.updateTotalPrice(id: product.id, change: .plus)
                } label: {
                    Text(Constants.plus)
                        .font(.system(size: 18))
                        .bold()
                }
            }
        }
    }
}

#Preview {
    ProductView()
}
