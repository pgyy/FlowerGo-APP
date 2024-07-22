import SwiftUI
import MapKit
import CoreLocation
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaBottom = window?.safeAreaInsets.bottom
struct MPV: View {
    @State var geo: CGSize = .zero
    private var startLocation_qmk = CLLocationCoordinate2D(latitude: 37.801, longitude: -122.404)
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            MapView(
            mapType: .standard,
            animated: false,
            altitude: 70000,
            pins: [
                MKPointAnnotation(
                __coordinate: CLLocationCoordinate2D(latitude: 37.801, longitude: -122.404)
                )
                ,
                MKPointAnnotation(
                __coordinate: CLLocationCoordinate2D(latitude: 37.901, longitude: -122.551)
                )
                ,
                MKPointAnnotation(
                __coordinate: CLLocationCoordinate2D(latitude: 37.769, longitude: -122.502)
                )
                ,
                MKPointAnnotation(
                __coordinate: CLLocationCoordinate2D(latitude: 37.676, longitude: -122.475)
                )
                ],
            startLocation: startLocation_qmk
            )
              .edgesIgnoringSafeArea(.all)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack(alignment: .leading, spacing:8) {
                VStack(alignment: .leading, spacing:0) {
                    VStack {}
                    .frame(width: 56, height: 56, alignment: .topLeading)
                    .background(Color(hex: 0x34c759))
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
                )
                VStack(alignment: .leading, spacing:0) {
                    VStack {}
                    .frame(width: 56, height: 56, alignment: .topLeading)
                    .background(Color(hex: 0x34c759))
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
                VStack(alignment: .leading, spacing:0) {
                    VStack {}
                    .frame(width: 56, height: 56, alignment: .topLeading)
                    .background(Color(hex: 0x34c759))
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
                VStack(alignment: .leading, spacing:0) {
                    VStack {}
                    .frame(width: 56, height: 56, alignment: .topLeading)
                    .background(Color(hex: 0x34c759))
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
            .padding(.bottom, safeAreaBottom)
            .padding([.horizontal, .top], 12)
            .fixedSize(horizontal: true, vertical: false)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .frame(minWidth: UIScreen.main.bounds.width, maxWidth: .infinity, minHeight: UIScreen.main.bounds.height, maxHeight: .infinity, alignment: .topLeading )
        .background(Color(hex: 0xdcedff).ignoresSafeArea())
        .saveSize(in: $geo)
        .ignoresSafeArea()
    }
    // MARK: additional structs
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
    MPV()
}
