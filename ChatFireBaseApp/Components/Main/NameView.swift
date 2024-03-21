//
//  NameView.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import SwiftUI
var username = ""
struct NameView: View {
    @State private var name = ""
    @State private var isRoomChat = false
    var body: some View {
        Text("Tên để có thể hiển thị tên của bạn cho mọi người biết")
        TextField("Nhập tên của bạn", text: $name)
            .textFieldStyle(OvalTextFieldStyle())
            .padding([.leading,.trailing])
        Button(action: {
            isRoomChat = true
            username = name
            
        }, label: {
            Text("Tiếp tục")
        }).buttonStyle(ButtonLogin())
            .padding()
            .fullScreenCover(isPresented: $isRoomChat ){
                RoomView()
            }
    }
}

#Preview {
    NameView()
}
//Button(action: {checkUser()}, label: {
//    Text("Đăng nhập")
//        .bold()
//        .font(.system(size: 13))
//}).buttonStyle(ButtonLogin())
//    .padding()
