//
//  Ticket.swift
//  MovieBooking
//
//  Created by Yohan on 2023-09-04.
//

import SwiftUI

struct Ticket: View {
    // initial states
    @State var title: String = "Thor"
    @State var subTitle: String = "Love And Thunder"
    @State var top: String = "thor-top"
    
    var gradient: [Color] = [Color("cyan"), Color("cyan").opacity(0), Color("cyan").opacity(0)]
    
    var body: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 4.0) {
                Text(title)
                    .fontWeight(Font.Weight.bold)
                
                Text(subTitle)
            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 250, height: 325, alignment: Alignment.top)
            .foregroundColor(.white)
            .background(
                Image(top)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
            )
            .mask(
                Image(top)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing), style: StrokeStyle(lineWidth: 2))
            }
            .cornerRadius(40, corners: [.topLeft, .topRight])
        }
        .frame(height: 460)
        .font(.footnote)
        .shadow(radius: 10)
    }
}

struct Ticket_Previews: PreviewProvider {
    static var previews: some View {
        Ticket()
    }
}
