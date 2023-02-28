//
//  EditViewModel.swift
//  Bucketlist
//
//  Created by Glenn Gijsberts on 06/07/2023.
//

import Foundation

extension EditView {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @MainActor class ViewModel: ObservableObject {
        @Published var loadingState = LoadingState.loading
        
        @Published var pages = [Page]()
        
        @Published var location: Location
        
        @Published var name: String
        @Published var description: String
        
        init(location: Location) {
            _location = Published(initialValue: location)
            
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        func save() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearbyPlaces() async {
            let items: Result? = await Networking.fetchData(location.locationDetailsEndpoint)
            
            if let result = items {
                pages = result.query.pages.values.sorted()
                
                loadingState = .loaded
            } else {
                loadingState = .failed
            }
        }
        
    }
}
