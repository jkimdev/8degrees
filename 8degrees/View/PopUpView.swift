//
//  PopUpView.swift
//  8degrees
//
//  Created by Jimmy on 2022/11/07.
//

import SwiftUI

struct PopUpView<Content: View>: View where Content: View {
    @Binding var isPresented: Bool
    @ViewBuilder let content: Content
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        if isPresented {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            content
        }
    }
}
