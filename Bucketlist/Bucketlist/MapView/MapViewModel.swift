//
//  MapViewModel.swift
//  Bucketlist
//
//  Created by Glenn Gijsberts on 06/07/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension MapView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.377956, longitude: 4.897070), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
        
        @Published private(set) var locations: [Location]
        
        @Published var selectedPlace: Location?
        
        @Published var isUnlocked = false
        
        let savePath = FileManager.documentsDirecotry.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }
            catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            
            locations.append(newLocation)
            
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func clear() {
            locations = []
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "we need to unlock your bucketlist"
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { succcess, authenticationError in
                    if succcess {
                        Task { @MainActor in
                            self.isUnlocked.toggle()
                        }
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}


