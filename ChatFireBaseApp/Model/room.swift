//
//  room.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import Foundation
import SwiftData
import FirebaseDatabase

@Model
class Room : ObservableObject{
    var room:String
    init(room: String) {
        self.room = room
    }
}
class RoomManager: ObservableObject {
    @Published var rooms: [String] = []
    private var ref = Database.database().reference().child("chatrooms")

    func loadRooms() {
        ref.observe(.value) { snapshot in
            var roomIDs: [String] = []
            for child in snapshot.children {
                if let roomSnapshot = child as? DataSnapshot {
                    let roomID = roomSnapshot.key
                    roomIDs.append(roomID)
                }
            }
            DispatchQueue.main.async {
                self.rooms = roomIDs
            }
        }
    }
    func addRooms(name: String) {
        let newRoomRef = ref.child(name)
        newRoomRef.setValue(["name": name])
    }
    func deleteRoom(roomName: String) {
        let roomRef = ref.child(roomName)
        roomRef.removeValue { error, _ in
            if let error = error {
                print("Error removing room: \(error)")
            } else {
                print("Room removed successfully")
            }
        }
    }

}
