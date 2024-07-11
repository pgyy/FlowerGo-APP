//
//  MapView.swift
//  FlowerGO_APP
//
//  Created by Peigen Yuan on 7/10/24.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.4075, longitude: -71.1190), span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
}



#Preview {
    MapView()
}
