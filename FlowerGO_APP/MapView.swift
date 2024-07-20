import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let newRegion = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
            parent.region = newRegion
            mapView.setRegion(newRegion, animated: true)
        }
    }
}

#Preview {
    StatefulPreviewWrapper(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.4075, longitude: -71.1190),
            span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
        )
    ) { region in
        MapView(region: region)
    }
}

struct StatefulPreviewWrapper<Content: View>: View {
    @State private var state: MKCoordinateRegion

    private var content: (Binding<MKCoordinateRegion>) -> Content

    init(_ state: MKCoordinateRegion, @ViewBuilder content: @escaping (Binding<MKCoordinateRegion>) -> Content) {
        _state = State(wrappedValue: state)
        self.content = content
    }

    var body: some View {
        content($state)
    }
}
