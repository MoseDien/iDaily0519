//
//  KeyboardAwareView.swift
//  PinView
//
//  Created by bell dien on 18/05/2025.
//


import SwiftUI
import Combine

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }

        let willHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ -> CGFloat in
                0
            }

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

struct KeyboardAwareView<Content: View>: View {
    @State private var keyboardHeight: CGFloat = 0
    let content: () -> Content

    var body: some View {
        VStack {
            content()
        }
        .padding(.bottom, keyboardHeight)
        .onReceive(Publishers.keyboardHeight) { height in
            withAnimation {
                self.keyboardHeight = height
            }
        }
    }
}

// 使用方式示例
struct KeyboardView: View {
    @State private var text = ""

    var body: some View {
        KeyboardAwareView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<30) { i in
                        Text("行 \(i)")
                    }

                    TextField("请输入内容", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                .padding()
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif
