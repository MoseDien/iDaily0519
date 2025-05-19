//
//  ScrollViewReader.swift
//  PinView
//
//  Created by bell dien on 16/05/2025.
//
import SwiftUI

struct XScrollViewReader: View {
    // @Namespace var topID // 错误用法
    // @Namespace var bottomID
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                Button("Scroll to Bottom") {
                    withAnimation {
                        proxy.scrollTo("bottom")
                    }
                }
                .id("top") // 用字符串作为 ID
                //.id(topID)
                
                VStack(spacing: 0) {
                    ForEach(0..<100) { i in
                        color(fraction: Double(i) / 100)
                            .frame(height: 32)
                    }
                }
                
                Button("Top") {
                    withAnimation {
                        proxy.scrollTo("top")
                    }
                }
                .id("bottom") // 同样用字符串 ID
                //.id(bottomID)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    func color(fraction: Double) -> Color {
        Color(red: fraction, green: 1 - fraction, blue: 0.5)
    }
}

#Preview {
    XScrollViewReader()
}
