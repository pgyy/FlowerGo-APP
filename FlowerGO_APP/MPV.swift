import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let starting = CLLocationCoordinate2D(latitude: 42.40775, longitude: -71.12060)
    static let rose = CLLocationCoordinate2D(latitude: 42.40770, longitude: -71.11882)
    static let petunia = CLLocationCoordinate2D(latitude: 42.40682, longitude: -71.11790)
    static let dahlia = CLLocationCoordinate2D(latitude: 42.40398, longitude: -71.11460)
}

struct MPV: View {
    @State private var showAnnotations = false
    @State private var mapItems: [MKMapItem] = []

    var body: some View {
        Map {
            Annotation(
                "Starting Pos",
                coordinate: .starting,
                anchor: .bottom
            ) {
                Image(systemName: "figure.wave")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.indigo)
                    .cornerRadius(4)
            }
            
            if showAnnotations {
                ForEach(mapItems, id: \.self) { mapItem in
                    let coordinate = mapItem.placemark.coordinate
                    let title = mapItem.name ?? "Unknown"
                    Annotation(title, coordinate: coordinate, anchor: .bottom) {
                        Image(systemName: "mappin")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .safeAreaInset(edge: .bottom) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        search(for: "flower")
                    }) {
                        Label("Show Nearby Flowers", systemImage: "mappin.and.ellipse")
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
    
    func search(for query: String) {
        // Create MKPlacemark instances
        let rosePlacemark = MKPlacemark(coordinate: .rose)
        let petuniaPlacemark = MKPlacemark(coordinate: .petunia)
        let dahliaPlacemark = MKPlacemark(coordinate: .dahlia)
        
        // Create MKMapItem instances
        let roseMapItem = MKMapItem(placemark: rosePlacemark)
        roseMapItem.name = "Rose"
        
        let petuniaMapItem = MKMapItem(placemark: petuniaPlacemark)
        petuniaMapItem.name = "Petunia"
        
        let dahliaMapItem = MKMapItem(placemark: dahliaPlacemark)
        dahliaMapItem.name = "Dahlia"
        
        // Update state
        mapItems = [roseMapItem, petuniaMapItem, dahliaMapItem]
        showAnnotations = true
    }
}

#Preview {
    MPV()
}
