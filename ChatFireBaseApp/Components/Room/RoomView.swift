//
//  RoomView.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import SwiftUI

struct RoomView: View {
    @ObservedObject var viewModel = RoomManager()
    @State var isShowingBottom = false
    @State private var selectedRoom: String?
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.rooms, id: \.self) { room in
                   NavigationLink(
                       destination: ChatView(room: room),
                       tag: room,
                       selection: $selectedRoom) {
                           Text(room)
                       }
               }
                .onDelete(perform: delete)
            }.background(Color.pink)
            .onAppear {
                viewModel.loadRooms()
            }
            .toolbar{
                Button(action: {add()}, label: {
                        Image(systemName: "plus")
                })
            }
        }.navigationTitle("Room")
            .background(Color.pink)
        .sheet(isPresented: $isShowingBottom, content: {
            AddNewRoom(isOpenSheet: $isShowingBottom)
                .presentationDetents([.height(500)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(20)
                
        })
    }
    func add(){
        isShowingBottom = true
    }

    func delete(indexSet : IndexSet){
            guard let index = indexSet.first else { return }
            let roomName = viewModel.rooms[index]
            print(roomName)
            viewModel.deleteRoom(roomName: roomName)
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
