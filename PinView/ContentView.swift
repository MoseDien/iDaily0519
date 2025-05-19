//
//  ContentView.swift
//  PinView
//
//  Created by bell dien on 16/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: {
                XScrollViewReader()
            }, label: {
                Text("ScrollViewReader")
            })
            NavigationLink(destination: {
                XNamespace()
            }, label: {
                Text("Namespace")
            })
            
            NavigationLink(destination: {
                AdaptiveScrollViewExample()
            }, label: {
                Text("AdaptiveScrollViewExample")
            })
            
            NavigationLink(destination: {
                MPinViewV1()
            }, label: {
                Text("MPinV1")
            })
            
            NavigationLink(destination: {
                MPinViewV2()
            }, label: {
                Text("MPinV2")
            })
            
            NavigationLink(destination: {
                KeyboardView()
            }, label: {
                Text("KeyboardView")
            })
            
            NavigationLink(destination: {
                StickyHeaderExample()
            }, label: {
                Text("StickyHeader")
            })
            
            NavigationLink(destination: {
                AdaptiveScrollViewExample()
            }, label: {
                Text("AdaptiveScroll")
            })
            
            NavigationLink(destination: {
                AdaptiveScrollViewIOS16Example()
            }, label: {
                Text("AdaptiveScroll-iOS16")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
