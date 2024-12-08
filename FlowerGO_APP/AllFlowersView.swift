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

    let flowers: [Flower] = Array(flowerDictionary.values) // Retrieve all flowers from the dictionary

    var body: some View {
        ZStack {
            // Main Grid of Flowers
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("All Flowers")
                        .font(.headline)
                        .foregroundColor(Color(hex: 0x1BC081))
                        .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(flowers) { flower in
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
                                        .font(.subheadline)
                                        .bold()
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
                FlowerDetailView(flower: flower, isPresented: $selectedFlower)
            }
        }
    }
}

struct FlowerDetailView: View {
    var flower: Flower
    @Binding var isPresented: Flower?

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
                Text(flower.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(hex: 0x2E8B57))

                Text(flower.description)
                    .font(.body)
                    .foregroundColor(.gray)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(flower.imageName, id: \.self) { imageName in
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .cornerRadius(10)
                                .clipped()
                        }
                    }
                }

                Spacer()

                Button(action: {
                    isPresented = nil // Close popup
                }) {
                    Text("Close")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(12)
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
