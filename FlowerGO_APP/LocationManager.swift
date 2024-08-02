//import SwiftUI
//struct ContentView: View {
//    var body: some View {
//        ZStack() {
//            VStack(spacing:0) {
//                Image(systemName: "hand.tap.fill")
//                  .font(.system(size: 22, weight: .regular))
//                  .imageScale(.small)
//                  .foregroundStyle(.white)
//                  .frame(width: 32, height: 32)
//                Text("Long Press")
//                  .font(.system(size: 17))
//                  .foregroundStyle(.white)
//                  .fixedSize(horizontal: false, vertical: true)
//                  .clipped()
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
//            .clipped()
//            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//            VStack(spacing:0) {
//                Image(systemName: "target")
//                  .font(.system(size: 22, weight: .regular))
//                  .frame(width: 32, height: 32)
//                Text("Double Tap")
//                  .font(.system(size: 17))
//                  .fixedSize(horizontal: false, vertical: true)
//                  .clipped()
//            }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
//            .clipShape(RoundedRectangle(cornerRadius: 200, style: .continuous))
//            .scaleEffect(0.6).opacity(0)
//            .offset(y: 100)
//        }
//        .frame(maxWidth: .infinity, alignment: .center)
//        .frame(height: 200, alignment: .center)
//        .background(Color(hex: 0x7fd2ff))
//        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
//        .overlay(
//        RoundedRectangle(cornerRadius: 24, style: .continuous)
//        .stroke(.black, style: StrokeStyle(lineWidth: 1, lineJoin: .round))
//        .opacity(0.1)
//        )
//        .ignoresSafeArea()
//    }
//}
//extension Color {
//    init(hex: Int, alpha: Double = 1.0) {
//        let red = Double((hex & 0xff0000) >> 16) / 255.0
//        let green = Double((hex & 0xff00) >> 8) / 255.0
//        let blue = Double((hex & 0xff) >> 0) / 255.0
//        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
//    }
//}
//#Preview {
//    ContentView()
//}
