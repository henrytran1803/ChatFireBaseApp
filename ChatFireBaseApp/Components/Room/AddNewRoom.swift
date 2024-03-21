//
//  AddNewRoom.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import SwiftUI

struct AddNewRoom: View {
    @ObservedObject var viewModel = RoomManager()
    @Binding var isOpenSheet: Bool
    @State var name = ""
    var body: some View {
          NavigationView {
              VStack {
                  TextField("Nhập tên phòng", text: $name)
                      .textFieldStyle(OvalTextFieldStyle())
                      .padding([.leading,.trailing])
                  
                  Spacer()
              }
              .navigationTitle("Thêm phòng mới")
              .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {
                      Button(action: {
                          isOpenSheet = false
                      }) {
                          Text("Huỷ")
                      }
                  }
                  
                  ToolbarItem(placement: .navigationBarTrailing) {
                      Button(action: {
                          addRoom()
                          isOpenSheet = false
                      }) {
                          Text("Xong")
                      }
                  }
              }
          }
      }
    func addRoom(){
        viewModel.addRooms(name: name)
    }
}

//#Preview {
//    let sOpenSheet = false
//    AddNewRoom(isOpenSheet: sOpenSheet)
//}
