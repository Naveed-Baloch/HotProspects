//
//  ContentView.swift
//  HotProspects
//
//  Created by Naveed on 05/10/2024.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct PracticMaterial: View {
    @State private var selectedTab = "One"
    
    @State private var output = ""
    
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
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
                Text("Change Color")
                    .padding()
                    .background(backgroundColor)
                    .contextMenu {
                        Button("Red") {
                            backgroundColor = .red
                        }
                        
                        Button("Green") {
                            backgroundColor = .green
                        }
                        
                        Button("Blue") {
                            backgroundColor = .blue
                        }
                    }
                
                List{
                    Text("Hello from List")
                        .swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/){
                            Button("Delete") {
                                print("delete item")
                            }
                        }
                }
                
                Button("Request Notification Permission") {
                    UNUserNotificationCenter.current()
                        .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error {
                                print(error.localizedDescription)
                            }
                        }
                }
                
                Button("Show Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
                
                Text(results)
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
    PracticMaterial()
}
