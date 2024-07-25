import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let starting = CLLocationCoordinate2D(latitude: 42.40759, longitude: -71.11977)
    static let rose = CLLocationCoordinate2D(latitude: 42.40770, longitude: -71.11882)
    static let petunia = CLLocationCoordinate2D(latitude: 42.40682, longitude: -71.11790)
    static let dahlia = CLLocationCoordinate2D(latitude: 42.40398, longitude: -71.11460)
}

struct MPV: View {
    @State private var showAlert = true
    @State private var showAnnotations = false
    @State private var mapItems: [MKMapItem] = []
    @State private var selectedTag: Int?
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var position: MapCameraPosition = .camera(
        MapCamera(centerCoordinate: .starting, distance: 600, heading: 242, pitch: 60))
    @State private var route: MKRoute?
    @State private var navigateToCamView = false
    
    let gradient = LinearGradient(
        colors: [.green, .blue, .green], startPoint: .leading, endPoint: .trailing
    )
    
    let stroke = StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [10, 10])

    var body: some View {
        NavigationStack {
            ZStack {
                Map(position: $position, selection: $selectedTag) {
                    Annotation(
                        "Tufts",
                        coordinate: .starting,
                        anchor: .bottom
                    ) {
                        Image(systemName: "tree")
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color.blue)
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
                                .scaleEffect(isSelected ? 3.0 : 2.0)
                                .animation(.spring(), value: isSelected)
                                .onTapGesture {
                                    selectedTag = index
                                    selectedCoordinate = coordinate
                                    withAnimation {
                                        position = .camera(MapCamera(centerCoordinate: coordinate, distance: 500, heading: 242, pitch: 60))
                                    }
                                }
                            }
                        }
                    }

                    if showAnnotations, let route {
                        MapPolyline(route)
                            .stroke(gradient, style: stroke)
                    }
                    
                    UserAnnotation()
                    
                }
                .mapStyle(.standard(elevation: .automatic))
                .safeAreaInset(edge: .bottom) {
                    VStack {
                        if showAnnotations, let selectedCoordinate = selectedCoordinate {
                            
                            HStack {
                                
                                Button(action: {
                                    withAnimation {
                                        position = .camera(MapCamera(centerCoordinate: selectedCoordinate, distance: 2000, heading: 242, pitch: 30))
                                    }
                                    getDirection()
                                }) {
                                    Text("GO!")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    navigateToCamView = true
                                }) {
                                    Text("I see a flower!")
                                        .font(.headline)
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .navigationDestination(isPresented: $navigateToCamView) {
                                    CamView()
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                toggleAnnotations()
                            }) {
                                Label(showAnnotations ? "Hide Nearby Flowers" : "Show Nearby Flowers", systemImage: "mappin.and.ellipse")
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
                
                if showAlert {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Welcome to Tufts!")
                            .font(.title)
                            .padding()
                        Text("You will see the campus of Tufts University. There are lots of flowers nearby. Walk around to find them! If you need some help, click the 'Show Nearby Flowers' button on the bottom of the screen to see some flowers we have found at those locations. Zoom in and out on the map to find them!")
                            .padding()
                        Button(action: {
                            showAlert = false
                        }) {
                            Text("Let's Go!")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .buttonStyle(.borderedProminent)
                        Spacer()
                    }
                    .frame(width: 300, height: 422)
                    .background(Color(UIColor.systemBackground).opacity(0.8))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                }
                
                VStack {
                    HStack {
                        Button(action: {
                            showAlert = true
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.title)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .background(Color(UIColor.systemBackground).opacity(0.9))
                        .cornerRadius(20)
                        .padding()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    func search(for query: String) {

        let rosePlacemark = MKPlacemark(coordinate: .rose)
        let petuniaPlacemark = MKPlacemark(coordinate: .petunia)
        let dahliaPlacemark = MKPlacemark(coordinate: .dahlia)
        

        let roseMapItem = MKMapItem(placemark: rosePlacemark)
        roseMapItem.name = "Rose"
        
        let petuniaMapItem = MKMapItem(placemark: petuniaPlacemark)
        petuniaMapItem.name = "Petunia"
        
        let dahliaMapItem = MKMapItem(placemark: dahliaPlacemark)
        dahliaMapItem.name = "Dahlia"
        

        mapItems = [roseMapItem, petuniaMapItem, dahliaMapItem]
        showAnnotations = true
    }

    func getDirection() {
        route = nil
        guard let selectedCoordinate = selectedCoordinate else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedCoordinate))
        request.transportType = .walking
        Task {
            let directions = MKDirections(request: request)
            do {
                let response = try await directions.calculate()
                route = response.routes.first
            } catch {
                print("Error calculating directions: \(error)")
            }
        }
    }
    
    func toggleAnnotations() {
        if showAnnotations {
            showAnnotations = false
        } else {
            search(for: "flower")
        }
    }

    func systemImageName(for title: String) -> String {
        return "camera.macro.circle.fill"
    }
}

#Preview {
    MPV()
}
