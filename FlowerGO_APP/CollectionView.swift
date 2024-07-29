//
//  Collection.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/28/24.
//

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
                        ForEach(viewModel.collection, id: \.self) { result in
                            VStack {
                                Text(result)
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 361, height: 500)
                                    .background(Color(hex: 0x1bc081))
                                    .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                            }
                        }
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
