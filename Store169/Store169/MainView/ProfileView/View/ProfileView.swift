//
//  ProfileView.swift
//  Store169
//
//  Created by Anastasiya Omak on 10/05/2024.
//

import SwiftUI

struct ProfileView: View {
    
    private enum Constants {
        static let nameLabel = "Marsupilami"
        static let cityLabel = "Palombia"
    }
    @ObservedObject var profileViewModel = ProfileViewModel()
    
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
                                profileInformation
                                Spacer()
                                    .frame(height: 47)
                                settingList
                        }
                            
                    }
                }
            }
        }
    }
    
    private var profileInformation: some View {
        VStack {
            Image(.marsupilami)
                .resizable()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            
            Text(Constants.nameLabel)
                .font(.system(size: 24, weight: .heavy))
                .foregroundStyle(.detailLabel)
            HStack {
                Image(.point)
                Text(Constants.cityLabel)
            }
        }
        .padding(.top, 45)
    }
    
    private var settingList: some View {
        List(profileViewModel.settings, id: \.name) { setting in
            
            setupSettingCell(setting: setting)
        }
        .listStyle(.plain)
        .padding(.horizontal, 40)
    }
    
    private func setupSettingCell(setting: Setting) -> some View {
        ZStack {
            NavigationLink(destination: {
                Text("")
            }) {
                Rectangle()
            }
            .opacity(0)
            
            HStack {
                Image(setting.iconName)
                Text(setting.name)
                Spacer()
                Image(setting.badge ?? "")
                
            }
            .foregroundStyle(.detailLabel)
        }
    }
    
    
}

#Preview {
    ProfileView()
}
