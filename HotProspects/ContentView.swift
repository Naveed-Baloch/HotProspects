//
//  ContentView.swift
//  HotProspects
//
//  Created by Naveed on 05/10/2024.
//

import SwiftUI

struct ContentView: View {
    private let users = ["Naveed", "ali", "Shahzad", "Momin"]
    @State private var selectedUser = Set<String>()
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                List(users, id: \.self, selection: $selectedUser) { user in
                    Text(user)
                }

                if selectedUser.isEmpty == false {
                    Text("You selected \(selectedUser.formatted())")
                }
            }
            .padding()
            .toolbar {
                EditButton()
            }
        
        }
        
        
    }
}

#Preview {
    ContentView()
}
