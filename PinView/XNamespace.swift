//
//  ContentView 2.swift
//  PinView
//
//  Created by bell dien on 16/05/2025.
//


import SwiftUI

struct XNamespace: View {
    @Namespace private var namespace
    @State private var isFlipped = false

    var body: some View {
        VStack {
            if isFlipped {
                Rectangle()
                    .matchedGeometryEffect(id: "shape", in: namespace)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            } else {
                Circle()
                    .matchedGeometryEffect(id: "shape", in: namespace)
                    .frame(maxWidth: .infinity, maxHeight: 400)
                    .foregroundColor(.red)
            }

            Button("Toggle") {
                withAnimation {
                    isFlipped.toggle()
                }
            }
        }
        .padding()
    }
}

#Preview {
    XNamespace()
}
