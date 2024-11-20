//
//  ResultCardView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/28/24.
//

import SwiftUI
import Combine
struct ResultCardView: View {
    var result: String
    @ObservedObject var viewModel: ResultViewModel
    var index: Int

    var isExpanded: Bool {
        viewModel.expandedIndex == index
    }

    var flower: Flower? {
        viewModel.getFlowerDetails(for: result)
    }

    var body: some View {
        DisclosureGroup(
            isExpanded: .constant(isExpanded),
            content: {
                if let flower = flower {
                    VStack(alignment: .leading) {
                        Text(flower.description)
                            .font(.subheadline)
                            .padding()

                        Image(flower.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 150)
                            .cornerRadius(10)

                        Button(action: {
                            viewModel.addToCollection(flower: flower)
                        }) {
                            Text("Collect!")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                } else {
                    Text("Details not available for this flower.")
                        .font(.subheadline)
                        .padding()
                }
            },
            label: {
                Text(result)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        )
        .padding(.vertical, 10)
    }
}


struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ResultViewModel()
        return ResultCardView(result: "Sample Result: confidence 0.95", viewModel: viewModel, index: 0)
    }
}

