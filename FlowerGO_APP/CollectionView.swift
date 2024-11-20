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

    var body: some View {
        VStack(alignment: .leading) {
            Text("Collected Flowers")
                .font(.title)
                .padding()

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.collection) { flower in
                        CardView(flower: flower)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CardView: View {
    let flower: Flower

    var body: some View {
        VStack {
            Image(flower.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 150)
                .cornerRadius(12)

            Text(flower.name)
                .font(.headline)

            Text(flower.description)
                .font(.subheadline)
                .lineLimit(2)
                .padding(.horizontal)
        }
        .frame(width: 200)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
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
