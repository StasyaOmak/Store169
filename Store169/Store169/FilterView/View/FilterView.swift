//
//  FilterView.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI
/// Фильтр по продукции
struct FilterView: View {
    
    private enum Constants {
        static let category = "Category"
        static let navigationTitle = "Filters"
        static let priceLabel = "Prices"
        static let colorLabel = "Color"
        static let minPrice = "$500"
        static let moreLabel = "More"
        static let backButtonIcon = "chevron.left"
        static let detailButtonIcon = "chevron.right"
    }

    let rows: [GridItem] = [
        .init(.fixed(50))
    ]
    
    let columns: [GridItem] = [
        .init(.fixed(70)),
        .init(.fixed(70)),
        .init(.fixed(70)),
        .init(.fixed(70)),
        .init(.fixed(70))
    ]
    
    var body: some View {
        NavigationView {
            
            ZStack {
                LinearGradient(colors: [.darkGreen, .darkGreen.opacity(0.2)], startPoint: .trailing, endPoint: .leading)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Color.white
                            .ignoresSafeArea(edges: .bottom)
                        VStack {
                            categoryView
                            pricesView
                            colorsView
                            Spacer()
                        }
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Constants.navigationTitle)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: Constants.backButtonIcon)
                        }
                        .tint(.white)
                    }
                    
                }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var filterViewModel = FilterViewModel()
    
    @State private var maxValue: CGFloat = 5000
    @State private var minPriceColor: Color = .detailLabel
    
        
    private var categoryView: some View {
        VStack() {
            categoryHeaderView
            categoryScrollView
        }
    }
    
    private var pricesView: some View {
        ZStack {
            VStack(alignment: .leading) {
                pricesHeaderView
                    .padding(.leading, -50)
                VStack(alignment: .leading, spacing: 0) {
                    pricesSliderView
                    pricesFooterView
                }
            }.padding()
            
            Text("$\(Int(maxValue))")
                .frame(width: 80, height: 24)
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.detailLabel)
                .offset(x: filterViewModel.positionValue, y: 35)
        }
    }
    
    private var categoryHeaderView: some View {
       
            HStack {
                Text(Constants.category)
                    .frame(width: 145, height: 30)
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(.detailLabel)
                    
                Spacer()
                HStack {
                    Text(Constants.moreLabel)
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.gray)
                    
                    Button {
                        
                    } label: {
                        Image(systemName: Constants.detailButtonIcon)
                            .foregroundColor(.gray)
                    }
                }
            }.padding(.top ,20)
            .padding(.trailing ,20)
    }
    
    private var categoryScrollView: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows)  {
                ForEach(0..<filterViewModel.categories.count) { index in
                    ZStack {
                        Color.backgroundGreen
                            .frame(width: 120, height: 80)
                            .cornerRadius(10)
                        Image(filterViewModel.categories[index].image)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }.shadow(
                        radius: 2, x: -2, y: 5
                    )
                }
            }
        }
        .padding(.leading, 20)
        .scrollIndicators(.never)
    }
    
    private var pricesHeaderView: some View {
        Text(Constants.priceLabel)
            .frame(width: 175, height: 30)
            .font(.system(size: 24))
            .bold()
            .foregroundColor(.detailLabel)
    }
    
    private var pricesSliderView: some View {
        Slider(value: Binding(get: {
            filterViewModel.sliderValue
        }, set: { newValue in
            filterViewModel.sliderValue = newValue
            filterViewModel.getPosition(for: newValue)
            maxValue = newValue
            updatePricePositionAppearance(newValue)
        }), in: 500...5000, step: 500) { _ in
            
        }
        .accentColor(.lightGreen)
        .onAppear {
            let progressCircleConfig = UIImage.SymbolConfiguration(scale: .small)
            UISlider.appearance()
                .setThumbImage(
                    UIImage(systemName: "circle.fill",
                            withConfiguration: progressCircleConfig
                           ), for: .normal)
        }
    }
    
    private var pricesFooterView: some View {
        Text(Constants.minPrice)
            .frame(width: 60, height: 24)
            .font(.system(size: 18))
            .bold()
            .foregroundColor(minPriceColor)
        
    }
        
    private var colorsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            colorsHeaderView
            colorLazyVGrid
        }.padding()
    }
    
    private var colorsHeaderView: some View {
        Text("\(Constants.colorLabel) \(filterViewModel.selectedColor)")
            .frame(width: 175, height: 30)
            .font(.system(size: 24))
            .bold()
            .foregroundColor(.detailLabel)
    }
    
    private var colorLazyVGrid: some View {
        LazyVGrid(columns: columns) {
            ForEach(0..<filterViewModel.colorSamples.count) { index in
                serColorView(colorSamples: filterViewModel.colorSamples[index]
                )
            }
        }
    }
    
    private func serColorView(colorSamples: ColorSample) -> some View {
        
        Button {
            filterViewModel.updateSelectedColor(colorSamples.id)
        } label: {
            if #available(iOS 17.0, *) {
                Color(colorSamples.color)
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                    .overlay(
                        Circle()
                            .stroke(.gray, lineWidth: 1))
            } else {
            }
        }
    }
    
    private func updatePricePositionAppearance(_ position: CGFloat) {
        minPriceColor = filterViewModel.sliderValue > 1500
        ? .loginGray
        : .white
    }
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = appearance
    }
}

#Preview {
    FilterView()
}


