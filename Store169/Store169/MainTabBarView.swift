//
//  MainTabBarView.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI

/// Таб бар
struct MainTabBarView: View {
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProductView()
                .tabItem {
                    Image(.store)
                        .renderingMode(.template)
                }
                .tag(0)
            BasketView()
                .tabItem {
                    Image(.basket)
                        .renderingMode(.template)
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Image(.profile)
                        .renderingMode(.template)
                }
                .tag(2)
        }
        .tint(.lightGreen)
    }
    
    @State private var selectedTab = 0
}

#Preview {
    MainTabBarView()
}

