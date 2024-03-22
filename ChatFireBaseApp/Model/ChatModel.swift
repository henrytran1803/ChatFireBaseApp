//
//  ChatModel.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 22/03/2024.
//

import Foundation
import FirebaseDatabase
import Combine
struct ChatMessage: Identifiable {
    var id: String
    var senderId: String
    var content: String
}

class ChatViewModel: ObservableObject {
    @Published var messages = [ChatMessage]()
    private var ref = Database.database().reference().child("chatrooms")
    private var cancellables = Set<AnyCancellable>()

    func fetchMessages(room: String) {
        var refmess = ref.child("\(room)").child("messages")
        refmess.observe(.value) { snapshot in
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

    func sendMessage(room: String, senderId: String, content: String) {
        let newRoomRef = ref.child("\(room)").child("messages")
        let messageData: [String: Any] = [
            "sender_id": senderId,
            "content": content
        ]
        newRoomRef.childByAutoId().setValue(messageData)
    }
}
