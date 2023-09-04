//
//  TicketView.swift
//  MovieBooking
//
//  Created by Yohan on 2023-09-04.
//

import SwiftUI

struct TicketView: View {
    // initial states
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("greenCircle"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? -50 : -130, y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 7).repeatForever()) {
                        animate.toggle()
                    }
                }
            
            Circle()
                .foregroundColor(Color("pinkCircle"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 100 : 130, y: animate ? 150 : 100)
            
            VStack (spacing: 30.0) {
                Text("Mobile Ticket")
                    .font(Font.title3)
                    .foregroundColor(.white)
                    .fontWeight(Font.Weight.bold)
                
                Text("Once you buy a movie ticket simply scan barcode to access to your movie")
                    .frame(maxWidth: 248)
                    .font(Font.body)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(TextAlignment.center)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.top)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color("backgroundColor"), Color("backgroundColor2")]), startPoint: .top, endPoint: .bottom))
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
