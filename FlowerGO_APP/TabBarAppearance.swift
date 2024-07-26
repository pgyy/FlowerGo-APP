// TabBarAppearance.swift
// FlowerGO_APP
//
// Created by Peigen Yuan on 7/25/24.
//

import SwiftUI

func setupTabBarAppearance() {
    let appearance = UITabBarAppearance()
    
    // Making the tab bar transparent
    appearance.configureWithTransparentBackground()
    
    // Customizing the icon and title appearance
    let normalAppearance = appearance.stackedLayoutAppearance.normal
    normalAppearance.iconColor = .systemBlue
    normalAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 10), .foregroundColor: UIColor.systemBlue]
    
    // Apply the appearance to the tab bar
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
}
