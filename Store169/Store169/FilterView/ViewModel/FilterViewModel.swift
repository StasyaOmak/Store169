//
//  FilterViewModel.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI
/// ViewModel для  каталога товаров
class FilterViewModel: ObservableObject {
    @Published var categories: [Category] = [
        Category(image: "bedScrollIcon"),
        Category(image: "sofaScrollIcon"),
        Category(image: "armchairIcon")
    ]
    
    let colorSamples: [ColorSample] = [
        ColorSample(colorName: "white", color: .white),
        ColorSample(colorName: "black", color: .black),
        ColorSample(colorName: "pink", color: .pink),
        ColorSample(colorName: "yellow", color: .yellow),
        ColorSample(colorName: "red", color: .red),
        ColorSample(colorName: "blue", color: .blue),
        ColorSample(colorName: "green", color: .green),
        ColorSample(colorName: "purple", color: .purple),
        ColorSample(colorName: "orange", color: .orange),
        ColorSample(colorName: "cyan", color: .cyan),
        ColorSample(colorName: "indigo", color: .indigo),
        ColorSample(colorName: "amaranth", color: .amaranth),
        ColorSample(colorName: "titian", color: .titian),
        ColorSample(colorName: "terracota", color: .terracota),
        ColorSample(colorName: "saffron", color: .saffron),
        ColorSample(colorName: "lime", color: .lime),
        ColorSample(colorName: "khaki", color: .khaki),
        ColorSample(colorName: "olive", color: .olive),
        ColorSample(colorName: "carmine", color: .carmine),
        ColorSample(colorName: "goldenrod", color: .goldenrod)
    ]
    
    @Published var sliderValue: Double = 5000 {
        didSet {
            getPosition(for: sliderValue)
        }
    }
    
    @Published var positionValue: CGFloat = 150
    
    @Published var selectedColor = ""
    
    func updateSelectedColor(_ colorCircleId: UUID) {
        if let index = colorSamples.firstIndex(where: { $0.id == colorCircleId }) {
            selectedColor = colorSamples[index].colorName
        }
    }
    
    private let sliderPositions: [Double: CGFloat] = [
        500: -160, 1000: -140, 1500: -100, 2000: -60, 2500: -20,
        3000: 20, 3500: 60, 4000: 100, 4500: 140, 5000: 160
    ]
    
    func getPosition(for sliderValue: Double) {
        if let position = sliderPositions[sliderValue] {
            positionValue = position
        } else {
            positionValue = 160
        }
    }
}
