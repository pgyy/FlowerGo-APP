//
//  ResultCardView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/28/24.
//
//import SwiftUI
//import Combine
//
//class ResultViewModel: ObservableObject {
//    @Published var expandedIndex: Int? = nil
//    @Published var collection: [String] = []
//    
//    func addToCollection(result: String) {
//        if !collection.contains(result) {
//            collection.append(result)
//        }
//    }
//}
//
//
//struct ResultCardView: View {
//    var result: String
//    @ObservedObject var viewModel: ResultViewModel
//    var index: Int
//    
//    var isExpanded: Bool {
//        viewModel.expandedIndex == index
//    }
//    
//    var body: some View {
//        DisclosureGroup(
//            isExpanded: .constant(isExpanded),
//            content: {
//                VStack {
//                    Text("Additional details about \(result)")
//                        .padding()
//                    Button(action: {
//                        viewModel.addToCollection(result: result)
//                    }) {
//                        Text("Collect")
//                            .font(.system(size: 17))
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                }
//                .padding() // Add padding to content
//            },
//            label: {
//                Text(result)
//                    .font(.system(size: 17))
//                    .foregroundColor(.white)
//                    .fixedSize(horizontal: false, vertical: true)
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .background(Color(hex: 0x7fd2ff))
//                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 24, style: .continuous)
//                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
//                    )
//                    .padding(.horizontal)
//                    .onTapGesture {
//                        withAnimation {
//                            viewModel.expandedIndex = isExpanded ? nil : index
//                        }
//                    }
//            }
//        )
//        .padding(.vertical, 16) // Increase vertical padding to avoid overlap
//    }
//}
//
//struct ResultCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = ResultViewModel()
//        return ResultCardView(result: "Sample Result: confidence 0.95", viewModel: viewModel, index: 0)
//    }
//}


import SwiftUI
import Combine

class ResultViewModel: ObservableObject {
    @Published var expandedIndex: Int? = nil
    @Published var collection: [String] = []
    
    func addToCollection(result: String) {
        print("Adding \(result) to collection")
        if !collection.contains(result) {
            collection.append(result)
        }
        print("Current collection: \(collection)")
    }
}

struct ResultCardView: View {
    var result: String
    @ObservedObject var viewModel: ResultViewModel
    var index: Int
    
    var isExpanded: Bool {
        viewModel.expandedIndex == index
    }
    
    var body: some View {
        DisclosureGroup(
            isExpanded: .constant(isExpanded),
            content: {
                VStack {
                    Text("Additional details about \(result)")
                        .padding()
                    Button(action: {
                        viewModel.addToCollection(result: result)
                    }) {
                        Text("Collect")
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding() // Add padding to content
            },
            label: {
                Text(result)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(hex: 0x7fd2ff))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24, style: .continuous)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation {
                            viewModel.expandedIndex = isExpanded ? nil : index
                        }
                    }
            }
        )
        .padding(.vertical, 16) // Increase vertical padding to avoid overlap
    }
}

struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ResultViewModel()
        return ResultCardView(result: "Sample Result: confidence 0.95", viewModel: viewModel, index: 0)
    }
}

