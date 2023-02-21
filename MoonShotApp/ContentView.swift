//
//  ContentView.swift
//  MoonShotApp
//
//  Created by Nick Pavlov on 2/19/23.
//

import SwiftUI

// Creating columns grid
let columnsOfGrid = [
    GridItem(.adaptive(minimum: 150))
]
let columnsOfList = [
    GridItem(.flexible(minimum: 150))
]

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    @State private var switchColumns = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // Performing list of missions
                LazyVGrid(columns: switchColumns ? columnsOfList: columnsOfGrid) {
                    ForEach(mission) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                
                                // Background of mission
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("MoonShot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            
            // Button to switch between Grid and List
            .toolbar {
                Button(switchColumns ? "Switch to List": "Switch to Grid") {
                    switchColumns.toggle()
                }
                .foregroundColor(.secondary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
