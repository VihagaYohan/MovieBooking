//
//  ContentView.swift
//  MovieBooking
//
//  Created by Yohan on 2023-09-04.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Tab = .home
    
    init() {
        UITabBar.appearance().isHidden = true // disable default tab bar
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            // initializing tab view
            TabView(selection: $currentTab) {
                Text("Home")
                    .tag(Tab.home)
                
                Text("Location")
                    .tag(Tab.location)
                
                TicketView()
                    .tag(Tab.ticket)
                
                Text("Category")
                    .tag(Tab.category)
                
                Text("Profile")
                    .tag(Tab.profile)
            }
            
            CustomTabBar(currentTab: $currentTab)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
