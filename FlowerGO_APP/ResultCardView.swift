//
//  ResultCardView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/28/24.
//
import SwiftUI

struct ResultCardView: View {
    var result: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(result)
                .font(.system(size: 17))
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(hex: 0x7fd2ff))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Color.black.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal)
        }
    }
}


struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        ResultCardView(result: "Sample Result: confidence 0.95")
    }
}
