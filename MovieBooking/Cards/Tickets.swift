//
//  Tickets.swift
//  MovieBooking
//
//  Created by Yohan on 2023-09-05.
//

import SwiftUI

struct Tickets: View {
    @State var tickets: [TicketModel] = [
        TicketModel(image:"thor", title:"Thor", subTitle: "Love and Thunder", top:"thor-top", bottom: "thor-bottom"),
        TicketModel(image: "panther", title:"Black Panther", subTitle: "Wakanda Forever", top: "panther-top", bottom: "panther-bottom"),
        TicketModel(image: "scarlet", title: "Doctor Strange", subTitle: "In the multiverse of madness", top: "scarlet-top", bottom: "scarlet-bottom")
    ]

    var body: some View {
        ZStack {
            ForEach(tickets) { ticket in
                InfiniteStackView(tickets: $tickets, ticket: ticket)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct Tickets_Previews: PreviewProvider {
    static var previews: some View {
        Tickets()
    }
}

struct InfiniteStackView: View {
    @Binding var tickets: [TicketModel]
    
    @GestureState var isDragging: Bool = false
    @State var offset: CGFloat = .zero
    @State var height: CGFloat = 0
    
    var ticket: TicketModel
    
    var body: some View {
        VStack {
            Ticket(
                title: ticket.title, subTitle: ticket.subTitle, top: ticket.top, bottom: ticket.bottom, height: $height)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .zIndex(getIndex() == 0 && offset > 100 ?  Double(CGFloat(tickets.count) - getIndex()) - 1 : Double(CGFloat(tickets.count) - getIndex()))
        .rotationEffect(.init(degrees: getRotation(angle: 10)))
        .rotationEffect(getIndex() == 1 ? .degrees(-6) : .degrees(0))
        .rotationEffect(getIndex() == 2 ? .degrees(6) : .degrees(0))
        .scaleEffect(getIndex() == 0 ? 1 : 0.9)
        .offset(x: getIndex() == 1 ? -40 : 0)
        .offset(x: getIndex() == 2 ? 40 : 0)
        .offset(x: offset)
        .gesture(
            DragGesture()
                .updating($isDragging, body: {_, out, _ in
                    out = true
                })
                .onChanged({ value in
                    var translation = value.translation.width
                    translation = tickets.first?.id == ticket.id ? translation : 0
                    translation = isDragging ? translation : 0
                    
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offset = translation
                        height = -offset / 5
                    }
                })
                .onEnded {value in
                    let width = UIScreen.main.bounds.width // screen width
                    let swipedRight: Bool = offset > (width / 2)
                    let swipedLeft: Bool = -offset > (width / 2)
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        if(swipedLeft) {
                            removeTicket()
                        }else {
                            if(swipedRight) {
                                offset = width
                                removeAdded()
                            }else {
                                offset = .zero
                                height = -offset / 5
                            }
                        }
                    }
                }
        )
    }
    
    func getIndex() -> CGFloat {
        let index = tickets.firstIndex { ticket in
            return self.ticket.id == ticket.id
        } ?? 0
        
        return CGFloat(index)
    }
    
    func getRotation(angle: Double) -> Double {
        let width = UIScreen.main.bounds.width // screen width
        let progress = offset / width
        
        return Double(progress * angle)
    }
    
    func removeAdded() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            var updatedTicket = ticket
            updatedTicket.id = UUID().uuidString
            
            tickets.append(updatedTicket)
            
            withAnimation(.spring()){
                tickets.removeFirst()
            }
        }
    }
    
    func removeTicket() {
        withAnimation(.spring()) {
            tickets.removeFirst()
        }
    }
}
