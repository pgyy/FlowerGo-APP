//
//  FlowerData.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 11/20/24.
//
import SwiftUI
import Foundation

struct Flower: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let imageName: [String]
    let description: String
    let ecosystemRole: String // New field
    let pollinators: [String] // New field
}

struct Pollinator: Identifiable {
    let id: UUID
    let name: String
    let imageName: String
    var position: CGPoint
}

let flowerDictionary: [String: Flower] = [
    "Rose": Flower(
        id: UUID(),
        name: "Rose",
        imageName: ["rose 1", "rose 2", "rose 3"],
        description: "Roses have prickly stems, glossy green leaves, and flowers that come in many colors, including white, yellow, orange, red, and pastel pink.",
        ecosystemRole: "Provides nectar for pollinators like bees and butterflies while serving as shelter for small insects.",
        pollinators: ["Bees", "Butterflies", "Hummingbirds"]
    ),
    "Sunflower": Flower(
        id: UUID(),
        name: "Sunflower",
        imageName: ["sunflower 1", "sunflower 2", "sunflower 3"],
        description: "The common sunflower has a green erect stem covered in coarse hairs, growing on average around 7 ft tall.",
        ecosystemRole: "Supports pollinators with abundant nectar and seeds for birds and small mammals. It also helps detoxify soil by absorbing heavy metals.",
        pollinators: ["Bees", "Butterflies", "Beetles"]
    ),
    "Tulip": Flower(
        id: UUID(),
        name: "Tulip",
        imageName: ["tulip 1", "tulip 2", "tulip 3"],
        description: "Tulips are erect flowers with broad, parallel-veined leaves and a cup-shaped flower at the top of the stem. The flowers can be single or double, and come in many colors",
        ecosystemRole: "Acts as an early spring nectar source for pollinators, particularly bees, and adds biodiversity to gardens.",
        pollinators: ["Bees", "Hoverflies"]
    ),
    "Orchid": Flower(
        id: UUID(),
        name: "Orchid",
        imageName: ["orchid 1", "orchid 2", "orchid 3"],
        description: "Orchids, found in wetland regions, release a spicy scent at dusk, attracting nocturnal pollinators like bats.",
        ecosystemRole: "Specialized in attracting specific pollinators, ensuring genetic diversity in ecosystems. Provides nectar for nocturnal animals.",
        pollinators: ["Bats", "Moths", "Bees"]
    ),
    "Lily": Flower(
        id: UUID(),
        name: "Lily",
        imageName: ["lily 1", "lily 2", "lily 3"],
        description: "Lilies have six petal-like segments that can form a variety of shapes, including trumpet, funnel, cup, bell, bowl, or flat. They can be many colors and often have markings or spots.",
        ecosystemRole: "Contributes to biodiversity by providing nectar and pollen for insects, and seeds for birds.",
        pollinators: ["Bees", "Butterflies", "Moths"]
    )
]
