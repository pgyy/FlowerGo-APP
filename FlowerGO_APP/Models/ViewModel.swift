import SwiftUI
import Combine

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
    @Published var hasPlantedRose: Bool = false

    init() {
        loadCollection()
        loadGarden()
    }

    func getFlowerDetails(for name: String) -> Flower? {
        return flowerDictionary[name]
    }
    
    func addToCollection(flower: Flower) {
            if !collection.contains(where: { $0.name == flower.name }) {
                collection.append(flower)
            }
        }

    func plantFlower(flower: Flower) {
        if !garden.contains(where: { $0.id == flower.id }) {
            objectWillChange.send() // Trigger the view update
            garden.append(flower)
            hasPlantedRose = true
            print("planting flower")
        }
    }

    func removeFromCollection(flower: Flower) {
        if let index = collection.firstIndex(of: flower) {
            collection.remove(at: index)
            garden.remove(at: index)
        }
    }

    func attractPollinator() {
        let pollinator = Pollinator(id: UUID(), name: "Butterfly", imageName: "butterfly", position: randomPosition())
        pollinators.append(pollinator)
        animatePollinator(pollinator)
    }

    private func randomPosition() -> CGPoint {
        CGPoint(x: CGFloat.random(in: 50...(UIScreen.main.bounds.width * 4 - 50)),
                y: CGFloat.random(in: 100...(UIScreen.main.bounds.height * 2 - 100)))
    }

    private func animatePollinator(_ pollinator: Pollinator) {
        guard let index = pollinators.firstIndex(where: { $0.id == pollinator.id }) else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                self.pollinators[index].position = self.randomPosition()
            }
        }
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
