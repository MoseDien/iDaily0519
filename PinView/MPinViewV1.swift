//
//  MPinView.swift
//  PinView
//
//  Created by bell dien on 18/05/2025.
//

import SwiftUI

struct MPinViewV1: View {
    @State private var number = "0"
    
    private enum Constants {
        static let backgroundOpacity: CGFloat = 0.5
        static let shadowRadius: CGFloat = 5
        static let cornerRadius: CGFloat = 8
        static let safeareaDigitalKeyboardLimit: CGFloat = 150
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Group {
                                Text("Authorisation required").font(.largeTitle)
                                Text("Enter your 6-digit PIN to authorise")
                                Text("This is the PIN you would have created when you set up your device.")
                            }
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .fixedSize(horizontal: false, vertical: true)
                            
                            TextField("Total number of people", text: $number)
                                .keyboardType(.numberPad)
                                .background(Color.gray)
                            Spacer().frame(height: 4)
                        }
                        .background(Color.white)
                    }
                    .frame(maxHeight: 400)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().frame(height: 4)
                }
            }
        }
    }
}
