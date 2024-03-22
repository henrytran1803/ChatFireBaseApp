//
//  ChatView.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//
import SwiftUI

struct ChatView: View {
    @State var room: String
    @ObservedObject var viewModel = ChatViewModel()
    @State var text = ""

    var body: some View {
        VStack {
            NavigationView {
                ScrollViewReader{ value in
                    List {
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            let message = viewModel.messages[index]
                            VStack {
                                HStack{
                                    Text("\(message.senderId)")
                                        .foregroundColor(.secondary)
                                        .font(.system(size: 10))
                                    Spacer()
                                } 
                                HStack{
                                    Text("\(message.content)")
                                        .font(.system(size: 20))
                                        .bold()
                                    Spacer()
                                }
                              
                                
                            }.multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,minHeight: 50)
                            .padding()
                            .background(randomColor())
                            .cornerRadius(8)
                            .opacity(0.7)
                            
                        }
                    }
                    .onAppear {
                        viewModel.fetchMessages(room: room)
                        value.scrollTo(viewModel.messages.last?.id)
                        
                    }
                    .navigationBarTitle(room)
                    .onReceive(viewModel.$messages) { _ in
                        viewModel.fetchMessages(room: room)
                    }
                }
                
            }
            HStack {
                TextField("Nhập tin nhắn", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if text.isEmpty{
                        
                    }else{
                        sentMess()
                    }
                }, label: {
                    Image(systemName: "paperplane")
                })
            }
            .padding()
        }.background(Color("backgroud"))
    }

    func sentMess() {
        viewModel.sendMessage(room: room, senderId: username, content: text)
        text = ""
        viewModel.fetchMessages(room: room)
    }
    private func randomColor() -> Color {
        let red = Double.random(in: 0..<1)
        let green = Double.random(in: 0..<1)
        let blue = Double.random(in: 0..<1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(room: "hello")
    }
}
