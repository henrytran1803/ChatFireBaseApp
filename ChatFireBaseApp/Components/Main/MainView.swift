//
//  MainView.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import SwiftUI

struct MainView: View {
    @State private var isshowing = false
    var body: some View {
        VStack{
            Spacer()
            Image("welcome")
                .resizable()
                .frame(width: 200,height: 200)
            Text("Chào mừng")
                .font(.title)
            Text("App chit-chat có thể chat với cộng đồng")
                .foregroundColor(.secondary)
            Spacer()
            Button(action: {isshowing = true}, label: {
                Text("Chào mừng")
            }).buttonStyle(ButtonLogin())
                .padding()
        }.fullScreenCover(isPresented: $isshowing){
            NameView()
        }
    }
}

#Preview {
    MainView()
}
