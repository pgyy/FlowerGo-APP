import SwiftUI
struct FlowerCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            VStack {}
            .frame(width: 56, height: 56, alignment: .topLeading)
            .background(.green)
            .cornerRadius(64).opacity(0.2)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: 0xffffff))
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
        RoundedRectangle(cornerRadius: 16, style: .continuous)
        .stroke(Color(hex: 0x0a84ff), style: StrokeStyle(lineWidth: 2, lineJoin: .round))
        .opacity(0.1)
        )
    }
}
//extension Color {
//    init(hex: Int, alpha: Double = 1.0) {
//        let red = Double((hex & 0xff0000) >> 16) / 255.0
//        let green = Double((hex & 0xff00) >> 8) / 255.0
//        let blue = Double((hex & 0xff) >> 0) / 255.0
//        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
//    }
//}
#Preview {
    FlowerCard()
}
