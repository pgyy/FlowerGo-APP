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

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Classifier Result:")
                .font(.headline)
                .foregroundColor(Color(hex: 0x1BC081))

            Text(result)
                .font(.title)
                .bold()
                .foregroundColor(Color(hex: 0x2E8B57))

//            Spacer()

            Button(action: {
                viewModel.addFlower(result) // Add the classifier result to collected flowers
            }) {
                Text("Collect Flower")
                    .font(.headline)
                    .padding()
                    .frame(width: 200)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: 0x34C759), Color(hex: 0x32ADE6)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .shadow(radius: 5)
                    .scaleEffect(1.1)
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ResultViewModel()
        return ResultCardView(result: "Test Flower", viewModel: viewModel)
    }
}
