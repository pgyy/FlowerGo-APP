////
////  GardenView.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/10/24.
////
import SwiftUI

struct GardenView: View {
    @State private var isPopupVisible = false
    @State private var isPollinatorPopupVisible = false // State for pollinator popup
    @State private var isPollinatorImagePopupVisible = false // State for pollinator image popup
    @State private var selectedPot = (row: 0, column: 0) // Track the clicked button's position
    @State private var selectedAsset: String? = nil // Track which asset is selected
    @State private var pollinatorForPot: String? = nil // Track the pollinator for the selected pot
    
    // List of asset names
    let assets = ["Rose", "Lily", "Orchid", "Sunflower", "Tulip"]
    let names = ["Bee", "Butterfly", "Bat", "Beetle", "Slug"]
    
    // State to track the planted plants in each pot
    @State private var plantedPlants = Array(repeating: Array(repeating: nil as String?, count: 2), count: 3) // 3x2 grid

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
                VStack(spacing: height * 0.06) {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: width * 0.1) {
                            ForEach(0..<2, id: \.self) { column in
                                ZStack {
                                    // Display planted plant if available
                                    if let plant = plantedPlants[row][column] {
                                        Image(plant)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: width * 0.375, height: height * 0.15)
                                    }
                                    
                                    // Transparent button for pot
                                    Button(action: {
                                        selectedPot = (row, column)
                                        if plantedPlants[row][column] != nil {
                                            // If there's a plant, show the pollinator popup
                                            isPollinatorPopupVisible = true
                                        } else {
                                            // Otherwise, show the planting popup
                                            isPopupVisible = true
                                        }
                                    }) {
                                        Circle()
                                            .fill(Color.clear) // Make the button area invisible
                                            .frame(width: width * 0.375, height: height * 0.15)
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.clear, lineWidth: 2) // Debugging border, remove for final version
                                            )
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(width: width, height: height)
                .padding(.top, height * 0.04)
            }

            // Planting Popup Overlay
            if isPopupVisible {
                ZStack {
                    Color.black.opacity(0.5) // Dim background
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Select a Plant for the Pot")
                            .font(.custom("ChalkboardSE-Bold", size: 20))
                            .foregroundColor(.white)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(assets, id: \.self) { asset in
                                    Button(action: {
                                        selectedAsset = asset // Set the selected asset
                                    }) {
                                        Image(asset)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .padding()
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(selectedAsset == asset ? Color.white : Color.clear, lineWidth: 2)
                                            )
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(height: 80)

                        Text(selectedAsset != nil ? "Selected: \(selectedAsset!)" : "No Flower Selected")
                            .foregroundColor(.white)
                            .font(.subheadline)

                        // Horizontal Buttons for Cancel and Plant
                        HStack {
                            Button(action: {
                                isPopupVisible = false
                            }) {
                                Text("Cancel")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                // Plant action: Update the grid with the selected plant
                                if let asset = selectedAsset {
                                    plantedPlants[selectedPot.row][selectedPot.column] = asset
                                }
                                isPopupVisible = false
                            }) {
                                Text("Plant")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAsset != nil ? Color.green : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .disabled(selectedAsset == nil)
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .transition(.opacity)
            }

            // Pollinator Popup Overlay
            if isPollinatorPopupVisible {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Attract a Pollinator?")
                            .font(.custom("ChalkboardSE-Bold", size: 24))
                            .foregroundColor(.white)

                        HStack {
                            Button(action: {
                                isPollinatorPopupVisible = false
                            }) {
                                Text("Cancel")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                            }
                            Button(action: {
                                // Generate a random pollinator and show the pollinator image popup
                                pollinatorForPot = names.randomElement()
                                isPollinatorPopupVisible = false
                                isPollinatorImagePopupVisible = true
                            }) {
                                Text("Yes")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .transition(.opacity)
            }

            // Pollinator Image Popup Overlay
            if isPollinatorImagePopupVisible {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Pollinator Attracted!")
                            .font(.custom("ChalkboardSE-Bold", size: 26))
                            .foregroundColor(.white)

                        if let pollinator = pollinatorForPot {
                            Image(pollinator)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            if let pollinatorData = pollinators[pollinator] {
                                Text(pollinatorData.description)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()

                                Text("Ecosystem Role: \(pollinatorData.role)")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }
                        }

                        Button(action: {
                            isPollinatorImagePopupVisible = false
                        }) {
                            Text("Close")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color.gray)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: isPopupVisible)
        .animation(.easeInOut, value: isPollinatorPopupVisible)
        .animation(.easeInOut, value: isPollinatorImagePopupVisible)
    }
}

// Preview Provider
struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
            .previewDevice("iPhone 14")
    }
}
