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
    @State private var selectedTag: Int?
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate:.starting, distance: 100, heading: 242, pitch: 60))

    var body: some View {
        Map(position: $position, selection: $selectedTag) {
            Annotation(
                "Starting Pos",
                coordinate: .starting,
                anchor: .bottom
            ) {
                Image(systemName: "figure.wave")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(Color.indigo)
                    .cornerRadius(10)
            }
            
            if showAnnotations {
                ForEach(Array(mapItems.enumerated()), id: \.element) { index, mapItem in
                    let coordinate = mapItem.placemark.coordinate
                    let title = mapItem.name ?? "Unknown"
                    let isSelected = (selectedTag == index)
                    Annotation(title, coordinate: coordinate, anchor: .bottom) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(isSelected ? Color.blue : Color.green)
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.secondary, lineWidth: 3)
                            Image(systemName: systemImageName(for: title))
                                .padding(5)
                                .foregroundColor(.white)
                        }
                        .scaleEffect(isSelected ? 1.5 : 1.0)
                        .animation(.spring(), value: isSelected)
                        .onTapGesture {
                            selectedTag = index
                        }
                    }
                }
            }
            
            UserAnnotation()
            
        }
        .mapStyle(.standard(elevation: .automatic))
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
        
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
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

    func systemImageName(for title: String) -> String {
        return "camera.macro.circle.fill"
    }
}

#Preview {
    MPV()
}
