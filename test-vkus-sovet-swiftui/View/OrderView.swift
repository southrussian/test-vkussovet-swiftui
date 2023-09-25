//
//  OrderView.swift
//  test-vkus-sovet-swiftui
//
//  Created by Danil Peregorodiev on 25.09.2023.
//

import Foundation
import SwiftUI

struct OrderView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 4) {
                    Text("Заказ")
                        .foregroundColor(.white)
                    Image(systemName: "rublesign.circle")
                }
                Image("kotik")
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            
        }
    }
}
