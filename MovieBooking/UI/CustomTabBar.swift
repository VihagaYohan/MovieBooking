//
//  CustomTabBar.swift
//  MovieBooking
//
//  Created by Yohan on 2023-09-06.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack(spacing: 0.0) {
            // loop through tab data
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(Animation.easeInOut) {
                        currentTab = tab
                    }
                }label: {
                     Image(tab.rawValue)
                        .renderingMode(.template)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                    
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.red)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        // CustomTabBar(currentTab: .constant(.home))
        ContentView()
    }
}
