//
//  StickyHeaderExample.swift
//  PinView
//
//  Created by bell dien on 18/05/2025.
//

import SwiftUI

struct HeaderOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct StickyHeader: View {
    var body: some View {
        GeometryReader { geometry in
            Text("📌 Section Header")
                .font(.headline)
                .padding()
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .preference(
                    key: HeaderOffsetKey.self,
                    value: geometry.frame(in: .global).minY
                )
        }
        .frame(height: 50) // 固定高度
    }
}

struct StickyHeaderExample: View {
    @State private var headerOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(spacing: 20) {
                    // 这是我们想让它吸顶的标题
                    StickyHeader()
                    
                    ForEach(0..<30) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.yellow.opacity(0.3))
                    }
                }
            }
            .onPreferenceChange(HeaderOffsetKey.self) { value in
                self.headerOffset = value
            }

            // 这个吸顶标题显示在屏幕顶部（当原始标题滚动出屏幕）
            if headerOffset < 0 {
                Text("📌 Section Header")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .shadow(radius: 4)
            }
        }
    }
}
