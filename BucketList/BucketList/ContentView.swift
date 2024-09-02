//
//  ContentView.swift
//  BucketList
//
//  Created by Andres Rivillas on 7/08/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    @State private var viewModel = ViewModel()
    @State var segmentationSelection : ProfileSection = .standard
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader{ proxy in
                    Map(initialPosition: startPosition){
                        ForEach(viewModel.locations) { location in
                            Annotation(
                                location.name,
                                coordinate: location.coordinate
                            ){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 35, height: 35)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }
                    .mapStyle(segmentationSelection.mapStyle)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace){ place in
                        EditView(location: place, onSave: {
                            viewModel.updateLocation(location: $0)
                        })
                    }
                }
                VStack {
                    Spacer()
                    Picker("", selection: $segmentationSelection) {
                        ForEach(ProfileSection.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding()
                }
            }
            
        } else {
            Button("Authenticate", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert(isPresented: $viewModel.showAuthenticationError, content: {
                    Alert(title: Text("Error"), message: Text("AuthenticationError"))
                })
        }
    }
}

enum ProfileSection: String, CaseIterable {
    case imagery
    case hybrid
    case standard
    
    var mapStyle: MapStyle {
        switch self {
        case .imagery:
            return .imagery
        case .hybrid:
            return .hybrid
        case .standard:
            return .standard
        }
    }
}
#Preview {
    ContentView()
}
