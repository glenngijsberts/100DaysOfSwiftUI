//
//  ContentView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

struct ContactsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var contacts: FetchedResults<CachedUser>
    
    @State private var showActive = false
    
    @MainActor
    func fetchContacts() async {
        if (!contacts.isEmpty) {
            return
        }

        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                decodedResponse.forEach { user in
                    let cachedUser = CachedUser(context: moc)
                    cachedUser.id = user.id
                    cachedUser.name = user.name
                    cachedUser.email = user.email
                    cachedUser.tags = user.tags.joined(separator: ", ")
                    cachedUser.company = user.company
                    cachedUser.age = Int16(user.age)
                    cachedUser.about = user.about
                    cachedUser.isActive = user.isActive
                    cachedUser.registered = user.registered
                    cachedUser.address = user.address
                    
                    user.friends.forEach {
                        let cachedFriend = CachedFriend(context: moc)
                        cachedFriend.id = $0.id
                        cachedFriend.name = $0.name
                        
                        cachedUser.addToFriends(cachedFriend)
                    }
                    
                    do {
                        try moc.save()
                    } catch {
                        print("Failed saving data")
                    }
                }
            }
        } catch {
            print("Failed fetching data")
        }
    }
    
    var body: some View {
        NavigationStack {
            ListView(showActive: showActive)
            .task {
                await fetchContacts()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showActive.toggle()
                    } label: {
                        Label("Sort", systemImage: showActive ? "person.crop.circle.badge.xmark" : "person.crop.circle.badge.checkmark")
                    }
                }
            }
            .navigationTitle("Contacts")
            .preferredColorScheme(.dark)
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
