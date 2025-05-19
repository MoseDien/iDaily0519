//
//  ContentHeightPreferenceKey.swift
//  PinView
//
//  Created by bell dien on 16/05/2025.
//


import SwiftUI

// 首先定义我们的 ContentHeightPreferenceKey
struct ContentHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// 定义我们的自适应滚动视图
struct AdaptiveScrollView<Content: View>: View {
    let content: Content
    @State private var contentHeight: CGFloat = 0
    @State private var availableHeight: CGFloat = 0
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            // 记录可用高度
            Color.clear.preference(key: ContentHeightPreferenceKey.self, value: outerGeometry.size.height)
                .onPreferenceChange(ContentHeightPreferenceKey.self) { height in
                    self.availableHeight = height
                }
            
            if contentHeight > availableHeight {
                // 内容高度超过可用高度，使用 ScrollView
                ScrollView {
                    content
                        .background(
                            GeometryReader { innerGeometry in
                                Color.clear.preference(
                                    key: ContentHeightPreferenceKey.self,
                                    value: innerGeometry.size.height
                                )
                            }
                        )
                }
                .onPreferenceChange(ContentHeightPreferenceKey.self) { height in
                    self.contentHeight = height
                }
            } else {
                // 内容高度未超过可用高度，不使用 ScrollView
                content
                    .background(
                        GeometryReader { innerGeometry in
                            Color.clear.preference(
                                key: ContentHeightPreferenceKey.self,
                                value: innerGeometry.size.height
                            )
                        }
                    )
                    .onPreferenceChange(ContentHeightPreferenceKey.self) { height in
                        self.contentHeight = height
                    }
            }
        }
    }
}

// 创建一个示例视图，演示如何使用 AdaptiveScrollView
struct AdaptiveScrollViewExample: View {
    @State private var number = "0"

    // 模拟数据源，可以调整数组长度来测试不同内容高度
    @State private var items: [String] = [
        "Item 1 - 点击 + 按钮添加更多项目，测试滚动行为",
        "Item 2 - 当内容高度小于屏幕高度时不会显示滚动条",
        "Item 3 - 当内容高度超过屏幕高度时会自动启用滚动"
    ]
    
    var body: some View {
        VStack {
            // 标题和控制按钮
            HStack {
                Text("AdaptiveScrollView 示例")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    // 添加新项目
                    items.append("Item \(items.count + 1) - 新添加的项目")
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                
                Button(action: {
                    // 移除最后一个项目
                    if !items.isEmpty {
                        items.removeLast()
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                }
            }
            .padding()
            
            // 使用我们的自适应滚动视图
            AdaptiveScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(items.indices, id: \.self) { index in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 30, alignment: .leading)
                            
                            Text(items[index])
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            TextField("Input your number", text: $number)

            // 底部信息
            VStack {
                Divider()
                Text("👆 当前有 \(items.count) 个项目")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            }
        }
    }
}

// 预览
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveScrollViewExample()
    }
}
