//
//  AllFlowersView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 12/6/24.
//

import SwiftUI

struct AllFlowersView: View {
    @ObservedObject var viewModel: ResultViewModel

    let flowers: [Flower] = Array(flowerDictionary.values) // Retrieve all flowers from the dictionary

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("All Flowers")
                .font(.headline)
                .foregroundColor(Color(hex: 0x1BC081))
                .padding(.horizontal)

            ForEach(flowers) { flower in
                VStack(alignment: .leading, spacing: 12) {
                    // Flower Name and Description
                    VStack(alignment: .leading) {
                        Text(flower.name)
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(hex: 0x2E8B57))
                            .padding(.bottom, 4)

                        Text(flower.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)

                    // Flower Image
                    Image(flower.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    AllFlowersView(viewModel: ResultViewModel())
}
