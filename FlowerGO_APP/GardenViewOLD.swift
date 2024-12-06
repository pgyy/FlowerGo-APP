////
////  GardenView.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/10/24.
////
//import SwiftUI
//
//struct GardenView: View {
//    @ObservedObject var viewModel: ResultViewModel
//    @State private var showPopUp = false
//    
//    var body: some View {
//        ZStack {
//            ZoomableView {
//                ZStack {
//                    Image("garden")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: UIScreen.main.bounds.width * 4, height: UIScreen.main.bounds.height * 2)
//                    
////                    ForEach(viewModel.garden) { flower in
////                        Image(flower.imageName)
////                            .resizable()
////                            .frame(width: 100, height: 100)
////                            .position(self.randomPosition())
////                    }
//                    
//                    ForEach(viewModel.pollinators) { pollinator in
//                        Image(pollinator.imageName)
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .position(pollinator.position)
//                            .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pollinator.position)
//                    }
//                }
//            }
//            .edgesIgnoringSafeArea(.all)
//            
//            VStack {
//                Spacer()
//                HStack {
//                    ForEach(viewModel.collection) { flower in
//                        Button(action: {
//                            viewModel.plantFlower(flower: flower)
//                        }) {
//                            Image(flower.imageName)
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                        }
//                        .padding()
//                    }
//                }
//                .background(Color.white.opacity(0.7))
//                .cornerRadius(10)
//                .padding()
//                
//                if viewModel.hasPlantedRose {
//                    Button(action: {
//                        viewModel.attractPollinator()
//                        showPopUp = true
//                    }) {
//                        Text("Attract Pollinators!")
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.green)
//                            .cornerRadius(10)
//                    }
//                    .padding()
//                }
//            }
//            
//            if showPopUp {
//                PopUpView()
//                    .transition(.scale)
//                    .onTapGesture {
//                        showPopUp = false
//                    }
//            }
//        }
//    }
//    
//    private func randomPosition() -> CGPoint {
//        CGPoint(x: CGFloat.random(in: 50...(UIScreen.main.bounds.width * 4 - 50)),
//                y: CGFloat.random(in: 100...(UIScreen.main.bounds.height * 2 - 100)))
//    }
//}
//
//
//struct PopUpView: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            Image("bee")
//                .resizable()
//                .frame(width: 32, height: 32)
//            Text("Congratulations! Your roses have attracted some bees")
//                .font(.headline)
//                .multilineTextAlignment(.center)
//            Text("Planting roses will help create a happy habitat for beneficial insects and you will notice busy bees going about their work when your roses are in bloom.")
//                .font(.subheadline)
//                .multilineTextAlignment(.center)
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(radius: 10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color.black.opacity(0.1), lineWidth: 1)
//        )
//        .padding()
//    }
//}
//
//
//#Preview {
//    GardenView(viewModel: ResultViewModel())
//}
