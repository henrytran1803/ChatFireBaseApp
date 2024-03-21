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
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.rooms, id: \.self){ room in
                    Text("\(room)")
//                    Text(username)
                }
                .onDelete(perform: delete)
            }
            .onAppear {
                viewModel.loadRooms()
            }
        }.navigationTitle("Room")
        .toolbar{
            Button(action: {add()}, label: {
                    Image(systemName: "plus")
            })
        }
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
