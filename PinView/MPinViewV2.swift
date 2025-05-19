
//
//  MPinViewV2.swift
//  PinView
//
//  Created by bell dien on 18/05/2025.
//

import SwiftUI

struct MPinViewV2: View {
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
                let size = proxy.size
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onAppear {
                        print("GeometryReader size: \(size)")
                    }
                
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Group {
                                Text("Width: \(Int(size.width)) Height: \(Int(size.height))")
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center).font(.footnote)
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
                    .frame(maxHeight: proxy.size.height * 0.8)
                    .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer().frame(height: 4)
                }
            }
        }
    }
}
