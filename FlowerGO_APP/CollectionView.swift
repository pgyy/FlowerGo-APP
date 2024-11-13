////
////  Collection.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/28/24.

import SwiftUI

let F_scenes = UIApplication.shared.connectedScenes
let F_windowScene = F_scenes.first as? UIWindowScene
let F_window = F_windowScene?.windows.first
let F_safeAreaTop = F_window?.safeAreaInsets.top

struct CollectionView: View {
    @ObservedObject var viewModel: ResultViewModel
    @State var geo1: CGSize = .zero
    @State var geo: CGSize = .zero
    @State private var isTextExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Collected Flowers:")
                    .font(.custom("ChalkboardSE-Bold", size: 24))
                    .foregroundColor(Color(hex: 0x1bc081))
                    .fixedSize(horizontal: false, vertical: true)

                // Expandable description text
                VStack(alignment: .leading, spacing: 8) {
                    Text(isTextExpanded ?
                         "Here are the flowers you've collected on your journey. Tap on each card to learn more about the flower and its unique characteristics!" :
                         "Here are the flowers you've collected. Tap on a card to learn more...")
                        .font(.custom("ChalkboardSE-Regular", size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(16)
                        .lineLimit(isTextExpanded ? nil : 2)
                        .animation(.easeInOut(duration: 0.3), value: isTextExpanded)
                        .onTapGesture {
                            isTextExpanded.toggle()
                        }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            GeometryReader { geometry in
                                let scale = getScale(geometry: geometry)

                                CardView(
                                    imageName: "house.fill",
                                    title: "Flower Name",
                                    guests: "Description",
                                    beds: "Functionality",
                                    baths: "Where it was collected"
                                )
                                .scaleEffect(scale)
                                .opacity(scale - 0.2)
                                .animation(.easeOut, value: scale)
                            }
                            .frame(width: 200, height: 300)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.top, 24)
        }
        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
        .background(Color(hex: 0xDFFFD6).ignoresSafeArea())
    }
}

struct CardView: View {
    var imageName: String
    var title: String
    var guests: String
    var beds: String
    var baths: String

    var body: some View {
        VStack {
            // Card image (Placeholder)
            Image(systemName: imageName)
                .foregroundColor(.clear)
                .frame(width: 240, height: 169)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0x1bc081), Color(hex: 0x32ade6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(16)

            // Card text
            VStack(alignment: .leading) {
                Text(title)
                    .font(.custom("ChalkboardSE-Bold", size: 16))
                    .foregroundColor(Color(hex: 0x003232))
                    .padding(.bottom, 3)

                VStack(alignment: .leading, spacing: 5) {
                    Label(guests, systemImage: "leaf.fill")
                        .font(.custom("ChalkboardSE-Regular", size: 12))
                        .foregroundColor(Color(hex: 0x003232))

                    Label(beds, systemImage: "camera.macro")
                        .font(.custom("ChalkboardSE-Regular", size: 12))
                        .foregroundColor(Color(hex: 0x003232))

                    Label(baths, systemImage: "map")
                        .font(.custom("ChalkboardSE-Regular", size: 12))
                        .foregroundColor(Color(hex: 0x003232))
                }
            }
            .padding(.horizontal, 13)
        }
        .frame(width: 250, height: 270)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: 0x32ade6), lineWidth: 1)
        )
    }
}

private func getScale(geometry: GeometryProxy) -> CGFloat {
    let midX = geometry.frame(in: .global).midX
    let screenMidX = UIScreen.main.bounds.width / 2
    let distance = abs(screenMidX - midX)
    let scale = max(0.8, 1 - (distance / UIScreen.main.bounds.width))
    return scale
}

#Preview {
    CollectionView(viewModel: ResultViewModel())
}
