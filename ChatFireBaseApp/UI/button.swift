//
//  button.swift
//  ChatFireBaseApp
//
//  Created by Tran Viet Anh on 21/03/2024.
//

import Foundation
import SwiftUI


struct ButtonLogin: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.pink : Color.purple)
            .foregroundStyle(.white)
            .cornerRadius(10)
        
    }

}
  
