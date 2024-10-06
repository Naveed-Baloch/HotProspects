//
//  ContentView.swift
//  HotProspects
//
//  Created by Naveed on 05/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    @State private var output = ""
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack{
                Button("Show Tab 2") {
                    selectedTab = "Two"
                }
                
                
                Button("Fetch Data") {
                    Task {
                        await fetchReadings()
                    }
                }
                
                Text("Readings \(output)")
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
        }
    }
    
    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Double].self, from: data)
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let success):
            output = String(success.count)
        case .failure(let failure):
            output = "Error: \(failure.localizedDescription)"
        }
        
    }
}

#Preview {
    ContentView()
}
