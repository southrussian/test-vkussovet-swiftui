//
//  TabView.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "info")
                }
        }
        .accentColor(.yellow)
        .onAppear {
             let tabBarAppearance = UITabBarAppearance()
             tabBarAppearance.configureWithOpaqueBackground()
             UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
             let navigationBarAppearance = UINavigationBarAppearance()
             navigationBarAppearance.configureWithOpaqueBackground()
             UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
