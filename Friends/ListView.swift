//
//  ListView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 11/02/2023.
//

import SwiftUI

struct ListView: View {
    @FetchRequest var contacts: FetchedResults<CachedUser>
    
    init(showActive: Bool) {
        _contacts = FetchRequest<CachedUser>(sortDescriptors: [], predicate: showActive ? NSPredicate(format: "isActive == true") : nil)
    }
    
    var body: some View {
        List(contacts) { contact in
            NavigationLink {
                ContactDetailsView(user: contact)
            } label: {
                RowView(user: contact)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(showActive: false)
    }
}
