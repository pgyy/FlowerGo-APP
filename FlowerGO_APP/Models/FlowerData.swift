//
//  FlowerData.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 11/20/24.
//
import SwiftUI
import Foundation

// The centralized dictionary for flower details
let flowerDictionary: [String: Flower] = [
    "Rose": Flower(
        id: UUID(),
        name: "Rose",
        imageName: "rose",
        description: "A beautiful flower known for its fragrance and symbolism of love."
    ),
    "Sunflower": Flower(
        id: UUID(),
        name: "Sunflower",
        imageName: "sunflower",
        description: "Bright yellow flowers that symbolize loyalty and happiness."
    ),
    "Tulip": Flower(
        id: UUID(),
        name: "Tulip",
        imageName: "tulip",
        description: "A popular spring flower with vibrant colors."
    )
]
