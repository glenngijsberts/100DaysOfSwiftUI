//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Glenn Gijsberts on 04/02/2023.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    enum PredicateType {
        case equals, beginsWith, contains
    }
    
    init(filterKey: String, filterValue: String, predicateType: PredicateType, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        func getPredicateType(predicate: PredicateType) -> String {
            switch predicate {
            case .beginsWith:
                return "BEGINSWITH"
            case .contains:
                  return "CONTAINS"
            case .equals:
                    return "=="
            }
        }
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(getPredicateType(predicate: predicateType)) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { wizard in
            self.content(wizard)
        }
    }
}
