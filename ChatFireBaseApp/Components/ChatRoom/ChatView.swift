//
//  ChatView.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//
import SwiftUI
import FirebaseDatabase

struct ChatMessage: Identifiable {
    var id: String
    var senderId: String
    var content: String
}

class ChatViewModel: ObservableObject {
    @Published var messages = [ChatMessage]()
    private var ref = Database.database().reference().child("chatrooms").child("room_id_1").child("messages")
    
    func fetchMessages() {
        ref.observe(.value) { snapshot in
            var newMessages = [ChatMessage]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let data = snapshot.value as? [String: Any] {
                    if let id = snapshot.key as? String,
                       let senderId = data["sender_id"] as? String,
                       let content = data["content"] as? String {
                        let message = ChatMessage(id: id, senderId: senderId, content: content)
                        newMessages.append(message)
                    }
                }
            }
            self.messages = newMessages
        }
    }
}

struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        List(viewModel.messages) { message in
            Text("\(message.senderId): \(message.content)")
        }
        .onAppear {
            viewModel.fetchMessages()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
