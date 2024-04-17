//
//  ContentView.swift
//  COMP3097_G21_W24_Project
//
//  Created by Abhishek Singhria on 2024-03-25.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isListScreenActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Grocery\n Buddy")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text("Name: Abhishek Singhria")
                    Text("Id: 101172285")
                    Text("Name: Kushal Patel")
                    Text("Id: 101378751")
                    Text("Name: Maharshi Barot")
                    Text("Id: 101380593")
                    Text("Name: Meha Modi")
                    Text("Id: 101371431")
                    Text("CRN: 50492")
                }
                .padding()
                
                Button(action: {
                    self.isListScreenActive = true
                }) {
                    Text("Start")
                        .frame(width: 300)
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink(
                    destination: ListScreen(),
                    isActive: $isListScreenActive,
                    label: { EmptyView() }
                )
                .hidden()
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
