//
//  ProfileView.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 4) {
                    Text("Профиль")
                        .foregroundColor(.white)
                    Image(systemName: "person.circle")
                }
                Image("kotik")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
        }
    }
}
