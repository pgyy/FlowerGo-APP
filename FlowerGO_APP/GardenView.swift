////
////  GardenView.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/10/24.
////
import SwiftUI

struct GardenView: View {
    
    @State private var isPopupVisible = false
    @State private var selectedPot = (row: 0, column: 0) // Track the clicked button's position
    @State private var selectedAsset: String? = nil // Track which asset is selected
    
    // List of asset names
    let assets = ["Rose", "Lily", "Orchid", "Sunflower", "Tulip"]
    
    var body: some View {
        ZStack {
            // Background Image
            Image("zen_garden")
                .resizable()
                .scaledToFill()
                .frame(width: 0, height: 880) // Set the desired size
                .ignoresSafeArea() // Extends image to the edges of the screen
            
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                // Grid layout
                VStack(spacing: height * 0.06) { // Adjust spacing as needed
                    ForEach(0..<3) { row in
                        HStack(spacing: width * 0.1) { // Adjust spacing as needed
                            ForEach(0..<2) { column in
                                Button(action: {
                                    selectedPot = (row, column)
                                    isPopupVisible = true
                                }) {
                                    Circle()
                                        .fill(Color.clear) // Make the button area invisible
                                        .frame(width: width * 0.375, height: height * 0.15) // Adjust size as needed
                                        .overlay(
                                            Circle()
                                                .stroke(Color.red, lineWidth: 2) // Debugging border, remove for final version
                                        )
                                }
                            }
                        }
                    }
                }
                .frame(width: width, height: height) // Match parent size
                .padding(.top, height * 0.04) // Adjust vertical offset to match the pots
            }

            // Popup Overlay
            if isPopupVisible {
                ZStack {
                    Color.black.opacity(0.5) // Dim background
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Select a Flower to Plant")
                            .font(.headline)
                            .foregroundColor(.white)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(assets, id: \.self) { asset in
                                    Button(action: {
                                        selectedAsset = asset // Set the selected asset
                                        print("Selected Asset: \(asset)")
                                    }) {
                                        Image(asset)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50) // Adjust size as needed
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(selectedAsset == asset ? Color.blue : Color.clear, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(height: 80) // Control the height of the scrollable area

                        Text(selectedAsset != nil ? "Selected: \(selectedAsset!)" : "No Asset Selected")
                            .foregroundColor(.white)
                            .font(.subheadline)

                        Button(action: {
                            isPopupVisible = false // Dismiss popup
                        }) {
                            Text("Close")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(width: 300) // Control the width of the popup
                    .background(Color.gray)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .transition(.opacity) // Smooth transition
            }
        }
        .animation(.easeInOut, value: isPopupVisible)
    }
}

// Preview Provider
struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
            .previewDevice("iPhone 14")
    }
}
