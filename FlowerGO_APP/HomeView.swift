import SwiftUI
import Charts
import MapKit
import CoreLocation
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
struct ContentView: View {
    @State private var navigateToMPV = false
    @State private var isTextExpanded = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Light green background
                Color(hex: 0xDFFFD6)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Title with custom playful font
                    Text("Discovering Tufts")
                        .font(.custom("ChalkboardSE-Bold", size: 34))
                        .foregroundColor(Color(hex: 0x2E8B57))
                        .padding()
                    
//                    VStack(spacing: 8) {
//                        Text(isTextExpanded ?
//                             "You are on a mission to discover flowers on the campus of Tufts University. Get into position, and look around for the flowers below!" :
//                             "You are on a mission to discover flowers on the campus of Tufts University. Get into position, and look around...")
//                            .font(.custom("ChalkboardSE-Regular", size: 18))
//                            .foregroundColor(.black)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .background(Color.white.opacity(0.8))
//                            .cornerRadius(16)
//                            .lineLimit(isTextExpanded ? nil : 2) // Expand to full text if clicked
//                            .animation(.easeInOut(duration: 0.3), value: isTextExpanded)
//
//                        // Button to expand or collapse text
//                        Button(action: {
//                            isTextExpanded.toggle()
//                        }) {
//                            Text(isTextExpanded ? "Show Less" : "Show More")
//                                .font(.custom("ChalkboardSE-Regular", size: 16))
//                                .foregroundColor(.blue)
//                                .padding(.vertical, 4)
//                        }
//                    }
                    
                    // Horizontal Scroll View for Images
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(1...3, id: \.self) { index in
                                Image("Image\(index)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 300, height: 200)
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding()
                    }
                    
                    // Step Guide with Icons
                    VStack(spacing: 16) {
                        stepView(icon: "1.circle.fill", text: "Look for Flowers", description: "Walk around campus to find flowers", color: 0x34C759)
                        stepView(icon: "2.circle.fill", text: "Take a Picture", description: "Capture the flower you found", color: 0x00C7BE)
                        stepView(icon: "3.circle.fill", text: "Collect", description: "Plant the flowers in your virtual garden", color: 0xFF3B30)
                        stepView(icon: "4.circle.fill", text: "Attract Pollinators", description: "See what kind of pollinators are attracted", color: 0x32ADE6)
                    }
                    
                    // Animated Button
                    Button(action: {
                        navigateToMPV = true
                    }) {
                        Text("Ready!")
                            .font(.headline)
                            .padding()
                            .frame(width: 200)
                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: 0x34C759), Color(hex: 0x32ADE6)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                            .scaleEffect(1.1)
//                            .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true))
                    }
                    .navigationDestination(isPresented: $navigateToMPV) {
                        MPV()
                    }
                }
                .padding()
            }
        }
    }
    // Helper View for Steps
    func stepView(icon: String, text: String, description: String, color: Int) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width: 50, height: 50) // Ensures consistent icon size
                .background(Color(hex: color))
                .cornerRadius(25) // Makes the icon circular
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .font(.custom("ChalkboardSE-Bold", size: 18))
                    .fixedSize(horizontal: false, vertical: true) // Allows multiline if needed
                
                Text(description)
                    .font(.custom("ChalkboardSE-Regular", size: 14))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true) // Allows multiline if needed
            }
            Spacer() // Pushes content to the left and ensures equal widths
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading) // Ensures uniform width
        .background(Color.white.opacity(0.8))
        .cornerRadius(16)
        .shadow(radius: 5)
    }

}
extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
// MARK: Enables setting individual vales per corner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
// MARK: Allows for percentage based layouts
struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content.background(
        GeometryReader { proxy in
            Color.clear
            .onAppear { size = proxy.size }
        }
        )
    }
}
extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
#Preview {
    ContentView()
}
