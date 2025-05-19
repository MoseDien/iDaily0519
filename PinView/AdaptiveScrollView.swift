import SwiftUI

// iOS 16+ 版本的自适应滚动视图
struct AdaptiveScrollViewIOS16<Content: View>: View {
    let content: Content
    @State private var contentHeight: CGFloat = 0
    @State private var availableHeight: CGFloat = 0
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                content
                    .background(
                        GeometryReader { innerGeometry -> Color in
                            DispatchQueue.main.async {
                                self.contentHeight = innerGeometry.size.height
                                self.availableHeight = geometry.size.height
                            }
                            return Color.clear
                        }
                    )
            }
            .scrollDisabled(contentHeight <= availableHeight)
            .overlay(alignment: .bottomTrailing) {
                // 调试信息，可以在实际应用中移除
                if #available(iOS 16.0, *) {
                    Text(contentHeight <= availableHeight ? "滚动已禁用" : "滚动已启用")
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(4)
                        .padding(8)
                }
            }
        }
    }
}

// 简单的测试示例
struct AdaptiveScrollViewIOS16Example: View {
    @State private var itemCount: Int = 3
    @State private var number = "0"
    
    var body: some View {
        VStack {
            // 标题和控制按钮
            HStack {
                Text("iOS 16+ 自适应滚动视图")
                    .font(.headline)
                Spacer()
                Button("添加项目") {
                    withAnimation {
                        itemCount += 1
                    }
                }
                Button("减少项目") {
                    withAnimation {
                        if itemCount > 0 {
                            itemCount -= 1
                        }
                    }
                }
                .disabled(itemCount == 0)
            }
            .padding()
            
            // 使用自适应滚动视图
            AdaptiveScrollViewIOS16 {
                VStack(spacing: 20) {
                    ForEach(0..<itemCount, id: \.self) { index in
                        ItemView(index: index)
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity)
            
            TextField("Input your number", text: $number)

            // 底部状态
            Text("项目数量: \(itemCount)")
                .padding()
                .font(.caption)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
            
        }
    }
}

// 列表项视图
struct ItemView: View {
    let index: Int
    
    var body: some View {
        HStack {
            Image(systemName: "doc.text.fill")
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text("项目 \(index + 1)")
                    .font(.headline)
                
                Text("这是项目描述，可以添加或减少项目来测试滚动行为。当内容高度不超过屏幕时不会滚动。")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

// 预览提供器
struct AdaptiveScrollViewIOS16Example_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveScrollViewIOS16Example()
    }
}
