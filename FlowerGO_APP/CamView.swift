//
//  CamView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/10/24.
//
import ARKit
import AVKit
import UIKit
import Vision
import SwiftUI

//struct CamView: View {
//    var body: some View {
//        VStack(spacing: 24) {
//            VStack (spacing: 24) {
//                VStack {
//                    Text("Scan the flower!")
//                        .font(.largeTitle)
//                        .colorInvert()
//                }
//                VStack {
////                    ViewControllerWrapper()
////                        .edgesIgnoringSafeArea(.all)
//                }
//                .frame(maxWidth: .infinity, alignment: .topLeading)
//                .frame(height: 500, alignment: .topLeading)
//                .background(.black)
//                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
//                ZStack() {
//                    VStack {}
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//                    .background(Color(hex: 0xffa755))
//                    .cornerRadius(50)
//                }
//                .padding(8)
//                .frame(width: 90, height: 90, alignment: .center)
//                .cornerRadius(50)
//                .overlay(
//                RoundedRectangle(cornerRadius: 50)
//                .stroke(Color(hex: 0xffa755), style: StrokeStyle(lineWidth: 8, lineJoin: .round))
//                )
//            }
//        }
//        .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .center)
//        .background(Color(hex: 0xffead8).ignoresSafeArea())
//    }
//}
import SwiftUI
import UIKit

struct CamView: View {
    var body: some View {
        NavigationView {
            ViewControllerWrapper()
                .edgesIgnoringSafeArea(.all) 
        }
    }
}

// This struct is used to wrap the UIViewController into SwiftUI
struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        // Return the UINavigationController with your ViewController as the root
        return UINavigationController(rootViewController: ViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

#Preview {
    CamView()
}
