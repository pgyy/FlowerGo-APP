////
////  Collection.swift
////  FlowerGO_APP
////
////  Created by Peigen Yuan on 7/28/24.

import SwiftUI

let F_scenes = UIApplication.shared.connectedScenes
let F_windowScene = F_scenes.first as? UIWindowScene
let F_window = F_windowScene?.windows.first
let F_safeAreaTop = F_window?.safeAreaInsets.top

struct CollectionView: View {
    
    @ObservedObject var viewModel: ResultViewModel
    @State var geo1: CGSize = .zero
    @State var geo: CGSize = .zero
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Collected Flowers:")
                    .font(.custom("SFProText-Medium", size: 24))
                    .foregroundStyle(Color(hex: 0x1bc081))
                    .fixedSize(horizontal: false, vertical: true)
                    .clipped()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 12) {
                        //new Carousel
                        HStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 25) {
                                    ForEach(0..<5, id: \.self) { _ in
                                        GeometryReader { geometry in
                                            let scale = getScale(geometry: geometry)
                                            
                                            CardView(
                                                imageName: "house.fill",
                                                title: "Flower Name",
                                                guests: "Description",
                                                beds: "Functionality",
                                                baths: "Where it was collected"
                                            )
                                            .scaleEffect(scale)
                                            .opacity(scale - 0.2)
                                            .animation(.easeOut, value: scale)
                                        }
                                        .frame(width: 200, height: 300)
                                    }
                                }
                                .padding(.top)
                            }
                        }
                        .frame(height: 300)
                        
                        
//                        ForEach(viewModel.collection, id: \.self) { flower in
//                            VStack {
//                                Text(flower.name)
//                                    .font(.system(size: 17))
//                                    .foregroundColor(.white)
//                                    .padding()
//                                    .frame(width: 361, height: 500)
//                                    .background(Color(hex: 0x1bc081))
//                                    .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
//                                
//                                Button(action: {
//                                    viewModel.removeFromCollection(flower: flower)
//                                }) {
//                                    Image(systemName: "trash")
//                                        .foregroundColor(.red)
//                                }
//                                .padding(.top, 8)
//                            }
//                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.top, 24)
        }
        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
        .background(Color(hex: 0xe1fdf3).ignoresSafeArea())
    }
}

struct CardView: View {
    var imageName: String
    var title: String
    var guests: String
    var beds: String
    var baths: String
    
    var body: some View {
        VStack {
            // Card image (Placeholder for now)
            Image(systemName: imageName) // Replace with actual image in your project
                .foregroundColor(.clear)
                .frame(width: 240, height: 169)
                .background(Color(red: 0.39, green: 0.39, blue: 0.39))
                .cornerRadius(10)
                
            // Card text
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(Font.custom("Alata", size: 16))
                        .foregroundColor(Color(red: 0, green: 0.25, blue: 0.23))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 3)
                    
//                    Label("", systemImage: "heart")
//                        .font(Font.custom("Alata", size: 20))
//                        .foregroundColor(Color(red: 0, green: 0.25, blue: 0.23))
//                        .frame(width: 20, height: 20, alignment: .trailing)
                }
                    
                VStack(alignment: .leading, spacing: 5) {
                    Label(guests, systemImage: "leaf.fill")
                        .font(Font.custom("Alata", size: 12))
                        .foregroundColor(Color(red: 0, green: 0.25, blue: 0.23))
                    
                    Label(beds, systemImage: "camera.macro")
                        .font(Font.custom("Alata", size: 12))
                        .foregroundColor(Color(red: 0, green: 0.25, blue: 0.23))
                    
                    Label(baths, systemImage: "map")
                        .font(Font.custom("Alata", size: 12))
                        .foregroundColor(Color(red: 0, green: 0.25, blue: 0.23))
                }
            }
            .padding(.horizontal, 13)
        }
        .frame(width: 250, height: 270)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color(red: 0.54, green: 0.75, blue: 0.71), lineWidth: 1)
        )
    }
}

private func getScale(geometry: GeometryProxy) -> CGFloat {
    let midX = geometry.frame(in: .global).midX
    let screenMidX = UIScreen.main.bounds.width / 2
    let distance = abs(screenMidX - midX)
    let scale = max(0.8, 1 - (distance / UIScreen.main.bounds.width))
    return scale
}

func transformValue(translateX: CGFloat = 0, translateY: CGFloat = 0, translateZ: CGFloat = 0, rotationX: CGFloat = 0, rotationY: CGFloat = 0, rotationZ: CGFloat = 0, perspective: CGFloat = 500, scaleX: CGFloat = 1, scaleY: CGFloat = 1) -> ProjectionTransform {
    func toRadians(_ value: CGFloat) -> CGFloat {
        return value * .pi / 180
    }
    var transform = CATransform3DIdentity
    transform.m34 = -1 / perspective
    transform = CATransform3DTranslate(transform, translateX, translateY, translateZ)
    transform = CATransform3DScale(transform, scaleX, scaleY, 1)
    transform = CATransform3DRotate(transform, toRadians(rotationX), 1, 0, 0)
    transform = CATransform3DRotate(transform, toRadians(rotationY), 0, 1, 0)
    transform = CATransform3DRotate(transform, toRadians(rotationZ), 0, 0, 1)
    return ProjectionTransform(transform)
}

#Preview {
    CollectionView(viewModel: ResultViewModel())
}
