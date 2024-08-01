//
//  GardenView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/10/24.
//
import SwiftUI

struct GardenView: View {
    @ObservedObject var viewModel: ResultViewModel
    
    var body: some View {
        ZoomableView {
            ZStack {
                Image("garden")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 2)
                
                ForEach(viewModel.garden) { flower in
                    Image(flower.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(self.randomPosition())
                }
                
                ForEach(viewModel.pollinators) { pollinator in
                    Image(pollinator.imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .position(pollinator.position)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))
                }
                
                VStack {
                    Spacer()
                    HStack {
                        ForEach(viewModel.collection) { flower in
                            Button(action: {
                                viewModel.plantFlower(flower: flower)
                            }) {
                                Image(flower.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .padding()
                        }
                    }
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func randomPosition() -> CGPoint {
        CGPoint(x: CGFloat.random(in: 50...(UIScreen.main.bounds.width * 1.5 - 50)),
                y: CGFloat.random(in: 100...(UIScreen.main.bounds.height * 1.5 - 100)))
    }
}

#Preview {
    GardenView(viewModel: ResultViewModel())
}
