//
//  CollectionClass.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/31/24.
//
import SwiftUI
import Combine

struct Flower: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
}

struct Pollinator: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    var position: CGPoint
}

class ResultViewModel: ObservableObject {
    @Published var expandedIndex: Int? = nil
    @Published var collection: [Flower] = [] {
        didSet {
            saveCollection()
        }
    }
    @Published var garden: [Flower] = [] {
        didSet {
            saveGarden()
        }
    }
    @Published var pollinators: [Pollinator] = []
    
    init() {
        loadCollection()
        loadGarden()
    }
    
    func addToCollection(result: String) {
        let flower = Flower(id: UUID(), name: result, imageName: "sunflower")
        if !collection.contains(where: { $0.name == flower.name }) {
            collection.append(flower)
        }
    }
    
    func plantFlower(flower: Flower) {
        if !garden.contains(where: { $0.id == flower.id }) {
            garden.append(flower)
            attractPollinator()
        }
    }
    
    func removeFromCollection(flower: Flower) {
        if let index = collection.firstIndex(of: flower) {
            collection.remove(at: index)
        }
    }
    
    private func attractPollinator() {
        let pollinator = Pollinator(id: UUID(), name: "Butterfly", imageName: "butterfly", position: CGPoint(x: .random(in: 50...300), y: .random(in: 50...500)))
        pollinators.append(pollinator)
    }
    
    private func saveCollection() {
        if let encoded = try? JSONEncoder().encode(collection) {
            UserDefaults.standard.set(encoded, forKey: "flowerCollection")
        }
    }
    
    private func loadCollection() {
        if let savedData = UserDefaults.standard.data(forKey: "flowerCollection"),
           let decoded = try? JSONDecoder().decode([Flower].self, from: savedData) {
            collection = decoded
        }
    }
    
    private func saveGarden() {
        if let encoded = try? JSONEncoder().encode(garden) {
            UserDefaults.standard.set(encoded, forKey: "garden")
        }
    }
    
    private func loadGarden() {
        if let savedData = UserDefaults.standard.data(forKey: "garden"),
           let decoded = try? JSONDecoder().decode([Flower].self, from: savedData) {
            garden = decoded
        }
    }
}
