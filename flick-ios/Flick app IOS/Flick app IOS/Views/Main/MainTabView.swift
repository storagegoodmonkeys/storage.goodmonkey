//
//  MainTabView.swift
//  Flick app IOS
//
//  Created by Muhammad Tayyab on 25/11/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            CollectionView()
                .tabItem {
                    Label("Collection", systemImage: "flame.fill")
                }
                .tag(1)
            
            MarketplaceView()
                .tabItem {
                    Label("Marketplace", systemImage: "cart.fill")
                }
                .tag(2)
            
            LostFoundView()
                .tabItem {
                    Label("Lost & Found", systemImage: "magnifyingglass")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(4)
        }
        .accentColor(AppTheme.primary)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppState())
}
