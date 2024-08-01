//
//  CollectionClass.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/31/24.
//
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


//import SwiftUI
//import Combine
//
//class ResultViewModel: ObservableObject {
//    @Published var expandedIndex: Int? = nil
//    @Published var collection: [String] = [] {
//        didSet {
//            saveCollection()
//        }
//    }
//    
//    init() {
//        loadCollection()
//    }
//    
//    func addToCollection(result: String) {
//        print("Adding \(result) to collection")
//        if !collection.contains(result) {
//            collection.append(result)
//        }
//        print("Current collection: \(collection)")
//    }
//    
//    private func saveCollection() {
//        UserDefaults.standard.set(collection, forKey: "flowerCollection")
//    }
//    
//    private func loadCollection() {
//        if let savedCollection = UserDefaults.standard.stringArray(forKey: "flowerCollection") {
//            collection = savedCollection
//        }
//    }
//}
