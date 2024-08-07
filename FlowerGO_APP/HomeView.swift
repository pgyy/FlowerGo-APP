import SwiftUI
import Charts
import MapKit
import CoreLocation
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
struct ContentView: View {
    @State var geo1: CGSize = .zero
    @State var geo2: CGSize = .zero
    @State var geo3: CGSize = .zero
    @State var geo4: CGSize = .zero
    @State var geo5: CGSize = .zero
    @State var geo: CGSize = .zero
    
    @State private var navigateToMPV = false
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (spacing: 16) {
                        VStack(spacing:12) {
                            ZStack() {}
                                .frame(width: geo1.width * 0.1, height: 4, alignment: .topLeading)
                                .background(.white.opacity(0))
                                .cornerRadius(16).opacity(0.1)
                            VStack(alignment: .leading, spacing:8) {
                                Text("Discovering Tufts")
                                    .textStyle(Large_Title())
                                    .bold()
                                Text("You are on a mission to discover flowers on the campus of Tufts University. Get into position, and look around for the flowers below!")
                                    .textStyle(Subhead_SemiBold())
                            }
                            .frame(width: 345, alignment: .topLeading)
                            .padding(.bottom, 12)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 8) {
                                    Image(systemName: "camera.macro.circle.fill")
                                        .font(.system(size: 17, weight: .regular))
                                        .imageScale(.small)
                                        .foregroundStyle(.white)
                                        .frame(width: 24, height: 24)
                                        .clipped()
                                        .background(Color(hex: 0x5856d6))
                                        .cornerRadius(64)
                                    Text("Flowers")
                                        .textStyle(Callout())
                                    Text("swipe to see more")
                                        .textStyle(Footnote())
                                }
                                .padding(16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(alignment: .top, spacing: 0) {
                                        Image("Image1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(minWidth: 361, maxWidth: 361, minHeight: 0, maxHeight: .infinity)
                                            .clipped()
                                        
                                        Image("Image2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(minWidth: 361, maxWidth: 361, minHeight: 0, maxHeight: .infinity)
                                            .clipped()
                                        
                                        Image("Image3")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(minWidth: 361, maxWidth: 361, minHeight: 0, maxHeight: .infinity)
                                            .clipped()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                .clipped()
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .frame(height: 284, alignment: .topLeading)
                            .background(Color(hex: 0xebebeb))
                            .clipped()
                            .cornerRadius(16)
                            
                            VStack(alignment: .leading, spacing:12) {
                                HStack(spacing: 10) {
                                    Image(systemName: "flag.circle.fill")
                                        .font(.system(size: 30, weight: .regular))
                                        .imageScale(.small)
                                        .foregroundStyle(.white)
                                        .frame(width: 24, height: 24)
                                        .clipped()
                                        .background(Color(hex: 0x5856d6))
                                        .cornerRadius(64)
                                    Text("Guide")
                                        .textStyle(Callout())
                                }
                                .frame(width: 321, alignment: .topLeading)
                                .saveSize(in: $geo2)
                                HStack(spacing:8) {
                                    Image(systemName: "1.circle.fill")
                                        .font(.system(size: 30, weight: .regular))
                                        .imageScale(.small)
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .clipped()
                                        .background(Color(hex: 0x34c759)).cornerRadius(64)
                                    VStack(alignment: .leading, spacing:0) {
                                        Text("Look for Flowers")
                                            .textStyle(Callout_1())
                                        Text("Walk around campus to find flowers")
                                            .textStyle(Footnote())
                                    }
                                    .frame(width: 240, alignment: .topLeading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing:8) {
                                    Image(systemName: "2.circle.fill")
                                        .font(.system(size: 30, weight: .regular))
                                        .imageScale(.small)
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .clipped()
                                        .background(Color(hex: 0x00c7be)).cornerRadius(64)
                                    VStack(alignment: .leading, spacing:0) {
                                        Text("Take a Picture")
                                            .textStyle(Callout_2())
                                        Text("Take a picture of the flower you found")
                                            .textStyle(Footnote_1())
                                    }
                                    .frame(width: 240, alignment: .topLeading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing:8) {
                                    Image(systemName: "3.circle.fill")
                                        .font(.system(size: 25, weight: .regular))
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .clipped()
                                        .background(Color(hex: 0xff3b30)).cornerRadius(64)
                                    VStack(alignment: .leading, spacing:0) {
                                        Text("Collect")
                                            .textStyle(Callout_3())
                                        Text("Plant the flowers in your virtual garden")
                                            .textStyle(Footnote_2())
                                    }
                                    .frame(width: 240, alignment: .topLeading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                HStack(spacing:8) {
                                    Image(systemName: "4.circle.fill")
                                        .font(.system(size: 25, weight: .regular))
                                        .foregroundStyle(.white)
                                        .frame(width: 32, height: 32)
                                        .clipped()
                                        .background(Color(hex: 0x32ade6)).cornerRadius(64)
                                    VStack(alignment: .leading, spacing:0) {
                                        Text("Attract Pollinators")
                                            .textStyle(Callout_4())
                                        Text("See what kind of pollinators are attracted")
                                            .textStyle(Footnote_3())
                                    }
                                    .frame(width: 240, alignment: .topLeading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .background(Color(hex: 0xebebeb))
                            .clipped()
                            .cornerRadius(16)
                            
                            Button(action: {
                                navigateToMPV = true
                            }) {
                                Text("Ready!")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .navigationDestination(isPresented: $navigateToMPV) {
                                MPV()
                            }
                            .padding(.bottom)
                            
                            Spacer(minLength: 100)
                        
                        }
                        .padding([.horizontal, .top], 16)
                        .padding(.bottom, 50)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                        .background(.white)
                        .opacity(0.9)
                        .clipped()
                        .cornerRadius(32, corners: [.topRight, .topLeft])
                        .offset(y: 50)
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: UIScreen.main.bounds.height, maxHeight: .infinity, alignment: .topLeading )
                .background(Color.white.ignoresSafeArea())
                .saveSize(in: $geo)
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
            .ignoresSafeArea()
        }
    }

    // MARK: additional structs
    struct Large_Title: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProDisplay-Bold", size: 30), size: 30)
            return 41 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProDisplay-Bold file to Xcode, and reference it below:
              .font(.custom("SFProDisplay-Bold", size: 30))
              .tracking(0.40)
              .frame(width: 345, alignment: .top)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .multilineTextAlignment(.center)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Subhead_SemiBold: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 15), size: 15)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 15))
              .tracking(-0.24)
              .frame(width: 345, alignment: .top)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .opacity(0.65)
              .multilineTextAlignment(.center)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Tag: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Medium", size: 11), size: 11)
            return 13 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Medium file to Xcode, and reference it below:
              .font(.custom("SFProText-Medium", size: 11))
              .tracking(0.07)
              .clipped()
              .foregroundStyle(.white)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Subhead_SemiBold_1: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 15), size: 15)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 15))
              .tracking(-0.24)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout_1: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x8e8e93))
              .opacity(0.85)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout_2: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_1: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x8e8e93))
              .opacity(0.85)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout_3: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_2: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x8e8e93))
              .opacity(0.85)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout_4: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_3: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x8e8e93))
              .opacity(0.85)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_4: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .frame(maxWidth: .infinity, alignment: .topLeading)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .opacity(0.45)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Callout_5: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 16), size: 16)
            return 21 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 16))
              .tracking(-0.32)
              .clipped()
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Subhead_SemiBold_2: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 15), size: 15)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 15))
              .tracking(-0.24)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct PlayChartPoint: Identifiable {
        var x: Double
        var y: Double
        var category: String
        var id = UUID()
    }
    struct Footnote_5: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .frame(maxWidth: .infinity, alignment: .topLeading)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .opacity(0.45)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Subhead_SemiBold_3: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 15), size: 15)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 15))
              .tracking(-0.24)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_6: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .opacity(0.65)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Subhead_SemiBold_4: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Semibold", size: 15), size: 15)
            return 20 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Semibold file to Xcode, and reference it below:
              .font(.custom("SFProText-Semibold", size: 15))
              .tracking(-0.24)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct Footnote_7: ViewModifier {
        var lineSpacing: CGFloat {
            let font: UIFont = .init(descriptor: .init(name: "SFProText-Regular", size: 13), size: 13)
            return 18 - font.lineHeight
        }
        func body(content: Self.Content) -> some View {
            content
            // MARK: Add SFProText-Regular file to Xcode, and reference it below:
              .font(.custom("SFProText-Regular", size: 13))
              .tracking(-0.08)
              .clipped()
              .foregroundStyle(Color(hex: 0x323232))
              .opacity(0.65)
              .fixedSize(horizontal: false, vertical: true)
              .lineSpacing(lineSpacing)
        }
    }
    struct MapView: UIViewRepresentable {
        var mapType: MKMapType
        var animated: Bool
        var altitude: Double
        var pins: [MKAnnotation] = []
        var startLocation: CLLocationCoordinate2D?
        var showsUserLocation: Bool?
        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.mapType = mapType
            mapView.addAnnotations(pins)
            if let coord = startLocation {
                mapView.setCenter(coord, animated: true)
                if let startPin = pins.first(where: {
                    $0.coordinate.latitude == coord.latitude && $0.coordinate.longitude == coord.longitude
                    }) {
                    mapView.selectAnnotation(startPin, animated: animated)
                }
            }
            if let optionalUserLoc = showsUserLocation {
                mapView.showsUserLocation = optionalUserLoc
            }
            mapView.delegate = context.coordinator
            return mapView
        }
        func updateUIView(_ mapView: MKMapView, context: Context) {
            mapView.camera.centerCoordinateDistance = altitude
        }
        func makeCoordinator() -> MapView.Coordinator {
            return Coordinator(self, altitude: altitude)
        }
        final class Coordinator: NSObject, MKMapViewDelegate {
            var control: MapView
            var altitude: Double
            init(_ control: MapView, altitude: Double) {
                self.control = control
                self.altitude = altitude
            }
            func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
                mapView.camera.centerCoordinateDistance = altitude
            }
        }
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
