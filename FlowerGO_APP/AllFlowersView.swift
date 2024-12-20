//
//  AllFlowersView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 12/6/24.
//

import SwiftUI

struct AllFlowersView: View {
    @ObservedObject var viewModel: ResultViewModel
    @State private var selectedFlower: Flower? // Tracks the currently selected flower for the popup
    @State private var zoomedImage: String?
    
    
    var allFlowers: [Flower] {
        let hardcodedFlowers = Array(flowerDictionary.values)
        
        // Create flower objects for collected names not in the dictionary
        let collectedFlowerObjects = viewModel.collectedFlowers.compactMap { flowerName -> Flower? in
            if let existingFlower = flowerDictionary[flowerName] {
                return existingFlower // Use the existing flower object if found
            } else {
                // Create a new flower object for unknown flowers
                return Flower(
                    id: UUID(),
                    name: flowerName, // Use the name from the collected list
                    imageName: ["unknown"], // Default image
                    description: "Details unknown for this flower.",
                    ecosystemRole: "Ecosystem role unkown for this flower",
                    pollinators: ["unknown pollinators"]
                )
            }
        }
        
        // Combine hardcoded flowers and collected flowers
        return hardcodedFlowers + collectedFlowerObjects
    }


    var body: some View {
        ZStack {
            // Light Green Background
            Color(hex: 0xDFFFD6)
                .ignoresSafeArea()

            // Main Grid of Flowers
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Spacer()
                        Text("Flower Collection :)")
                            .font(.custom("ChalkboardSE-Bold", size: 26))
                            .foregroundColor(Color(hex: 0x2E8B57))
                            .padding()
                        Spacer()
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(allFlowers) { flower in
                            Button(action: {
                                selectedFlower = flower // Set the selected flower to show its details
                            }) {
                                VStack {
                                    Image(flower.imageName.first ?? "") // Display the first image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .clipped()

                                    Text(flower.name)
                                        .font(.custom("ChalkboardSE-Bold", size: 14))
                                        .foregroundColor(Color(hex: 0x2E8B57))
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 120, height: 150)
                                .background(Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 16)
            }

            // Popup/Zoom-In View for Selected Flower
            if let flower = selectedFlower {
                            FlowerDetailView(flower: flower, isPresented: $selectedFlower, zoomedImage: $zoomedImage)
                        }

            // Full-Screen Zoom-In Image
            if let zoomedImage = zoomedImage {
                ZStack {
                    Color.black.opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            self.zoomedImage = nil // Close the zoomed image
                        }

                    Image(zoomedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            self.zoomedImage = nil // Close the zoomed image
                        }
                }
                .animation(.easeInOut, value: zoomedImage)
            }
        }
    }
}


struct FlowerDetailView: View {
    var flower: Flower
    @Binding var isPresented: Flower?
    @Binding var zoomedImage: String?

    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = nil // Close popup when tapping outside
                }

            // Flower Detail Card
            VStack(alignment: .leading, spacing: 16) {
                // Flower Name
                HStack {
                    Spacer() // Push content to the center
                    Text(flower.name)
                        .font(.custom("ChalkboardSE-Bold", size: 30))
                        .foregroundColor(Color(hex: 0x2E8B57))
                        .padding()
                    Spacer() // Push content to the center
                }

                // Flower Description
                Text(flower.description)
                    .font(.custom("ChalkboardSE", size: 18))
                    .foregroundColor(.gray)
                    .padding()

                // Ecosystem Role
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        Text("Ecosystem Role:")
                            .font(.custom("ChalkboardSE-Bold", size: 24))
                            .foregroundColor(Color(hex: 0x2E8B57))
                            .padding(.horizontal)
                        Spacer()
                    }
                    Text(flower.ecosystemRole)
                        .font(.custom("ChalkboardSE", size: 18))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                }

                // Pollinators
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Spacer()
                        Text("Pollinators:")
                            .font(.custom("ChalkboardSE-Bold", size: 24))
                            .foregroundColor(Color(hex: 0x2E8B57))
                            .padding(.horizontal)
                        Spacer()
                    }
                    HStack(spacing: 10) {
                        Spacer()
                        ForEach(flower.pollinators, id: \.self) { pollinator in
                            Text(pollinator)
                                .font(.custom("ChalkboardSE-Bold", size: 15))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(hex: 0xFFD700).opacity(0.8))
                                .cornerRadius(8)
                        }
                        Spacer()
                    }
                }

                
                // Images
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(flower.imageName, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                                .clipped()
                                .onTapGesture {
                                    self.zoomedImage = imageName // Set the zoomed image
                                }
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()

                HStack {
                    Spacer()
                    // Close Button
                    Button(action: {
                        isPresented = nil // Close popup
                    }) {
                        Text("Close")
                            .font(.headline)
                            .padding()
                            .frame(width: 200)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x34C759), Color(hex: 0x32ADE6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                            .scaleEffect(1.1)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: 350)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    AllFlowersView(viewModel: ResultViewModel())
}
