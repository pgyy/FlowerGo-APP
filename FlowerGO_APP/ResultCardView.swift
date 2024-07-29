//
//  ResultCardView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/28/24.
//
import SwiftUI

struct ResultCardView: View {
    var result: String
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                Text("Additional details about \(result)")
                    .padding()
            },
            label: {
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
        )
        .animation(.easeInOut, value: isExpanded)
        .padding(.vertical, 8)
    }
}


struct ResultCardView_Previews: PreviewProvider {
    static var previews: some View {
        ResultCardView(result: "Sample Result: confidence 0.95")
    }
}

#Preview {
    ResultCardView(result: "Sample Result: confidence 0.95")
}
