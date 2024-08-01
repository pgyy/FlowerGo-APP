//
//  CamView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/10/24.
//
import SwiftUI
import UIKit

struct CamView: View {
    @State private var navigateToMapView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ViewControllerWrapper()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    Button(action: {
                        navigateToMapView = true
                        
                    }) {
                        Text("Back to Home")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 100)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(NavigationLink(destination: FlowerGoTabView(), isActive: $navigateToMapView) { EmptyView() })
            }
            .navigationBarHidden(true)
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
