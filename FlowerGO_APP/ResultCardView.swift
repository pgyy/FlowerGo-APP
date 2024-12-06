////
////  ResultCardView.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/28/24.
////
//
//import SwiftUI
//import Combine
//
//
//struct ResultCardView: View {
//    var result: String
//    @ObservedObject var viewModel: ResultViewModel
//    var index: Int
//
//    var flower: Flower? {
//        viewModel.getFlowerDetails(for: result)
//    }
//
//    var body: some View {
//        DisclosureGroup(
//            isExpanded: Binding(
//                get: { viewModel.expandedIndex == index },
//                set: { isExpanded in
//                    viewModel.expandedIndex = isExpanded ? index : nil
//                }
//            ),
//            content: {
//                if let flower = flower {
//                    VStack(alignment: .leading, spacing: 16) {
//                        // Flower Name and Description
//                        VStack(alignment: .leading) {
//                            Text(flower.name)
//                                .font(.title)
//                                .bold()
//                                .foregroundColor(Color(hex: 0x2E8B57))
//                                .padding(.bottom, 4)
//
//                            Text(flower.description)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .padding(.horizontal)
//
//                        // Flower Pictures
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 16) {
//                                ForEach(["rosePics1", "rosePics2", "rosePics3"], id: \.self) { imageName in
//                                    Image(imageName)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 120, height: 120)
//                                        .clipped()
//                                        .cornerRadius(10)
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//
//                        // Flower Functionality
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("Functionality")
//                                .font(.headline)
//                                .foregroundColor(Color(hex: 0x1BC081))
//
//                            Text("Symbol of love and beauty. Used in perfumes and decorations.")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                        .padding(.horizontal)
//
//                        // Potential Pollinators
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("Attracts Pollinators")
//                                .font(.headline)
//                                .foregroundColor(Color(hex: 0x1BC081))
//
//                            HStack(spacing: 10) {
//                                ForEach(["Bees", "Butterflies"], id: \.self) { pollinator in
//                                    Text(pollinator)
//                                        .font(.subheadline)
//                                        .padding(.horizontal, 8)
//                                        .padding(.vertical, 4)
//                                        .background(Color(hex: 0xFFD700).opacity(0.8))
//                                        .cornerRadius(8)
//                                }
//                            }
//                        }
//                        .padding(.horizontal)
//
//                        // Collect Button
////                        Button(action: {
////                            if let flower = flower {
////                                viewModel.addToCollection(flower: flower)
////                            }
////                        }) {
////                            Text("Collect!")
////                                .font(.headline)
////                                .foregroundColor(.white)
////                                .padding()
////                                .frame(maxWidth: .infinity)
////                                .background(Color(hex: 0x34C759))
////                                .cornerRadius(12)
////                        }
////                        .padding(.horizontal)
//                    }
//                } else {
//                    Text("Details not available for this flower.")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding()
//                }
//            },
//            label: {
//                Text(result)
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        )
//        .padding(.vertical, 10)
//        .padding(.horizontal, 16)
//    }
//}
//
//struct ResultCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = ResultViewModel()
//        return ResultCardView(result: "Rose", viewModel: viewModel, index: 1)
//    }
//}
//
import SwiftUI
import Combine

struct ResultCardView: View {
    var result: String
    @ObservedObject var viewModel: ResultViewModel

    var flower: Flower? {
        viewModel.getFlowerDetails(for: result)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Classifier Result Header
            Text("Classifier Result:")
                .font(.headline)
                .foregroundColor(Color(hex: 0x1BC081))

            // Display the Resulting Flower Name
            if let flower = flower {
                VStack(alignment: .leading, spacing: 12) {
                    Text(flower.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(hex: 0x2E8B57))

                    Text(flower.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Image(flower.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 150)
                        .cornerRadius(10)
                }
            } else {
                // Fallback if Flower Not Found
                Text("No matching flower found.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
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
        return ResultCardView(result: "Rose", viewModel: viewModel)
    }
}
