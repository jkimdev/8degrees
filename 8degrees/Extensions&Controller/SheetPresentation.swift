//
//  SheetPresentation.swift
//  8degrees
//
//  Created by 김재민 on 2022/10/09.
//

import Foundation
import SwiftUI

struct SheetPresentation<Content>: UIViewRepresentable where Content: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let content: Content
    
    init(_ isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, detents: [UISheetPresentationController.Detent] = [.medium()], @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.detents = detents
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let viewController = UIViewController()
        let hostingController = UIHostingController(rootView: content)
        
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: viewController.view.topAnchor).isActive = true
        hostingController.view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor).isActive = true
        hostingController.didMove(toParent: viewController)
        
        if let sheetController = viewController.presentationController as? UISheetPresentationController {
            sheetController.detents = detents
            sheetController.prefersGrabberVisible = true
            sheetController.prefersScrollingExpandsWhenScrolledToEdge = false
            sheetController.largestUndimmedDetentIdentifier = .medium
        }
        
        viewController.presentationController?.delegate = context.coordinator
        
        if isPresented {
            
            uiView.window?.rootViewController?.present(viewController, animated: true)
        } else {
            
            uiView.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isPresented: $isPresented, onDismiss: onDismiss)
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?
        
        init(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
            if let onDismiss = onDismiss {
                onDismiss()
            }
        }
    }
}

struct sheetWithDetentsViewModifier<PageContent>: ViewModifier where PageContent: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let pageContent: PageContent
    
    init(isPresented: Binding<Bool>, detents: [UISheetPresentationController.Detent] = [.medium()] , onDismiss: (() -> Void)? = nil, content: () -> PageContent) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.detents = detents
        self.pageContent = content()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            SheetPresentation($isPresented, onDismiss: onDismiss, detents: [.medium()]) {
                pageContent
            }.fixedSize()
            content
        }
    }
}

extension View {
    func sheetWithDetents<Content>(
        isPresented: Binding<Bool>,
        dentents: [UISheetPresentationController.Detent],
        onDismiss: (() -> Void)?,
        content: @escaping () -> Content) -> some View where Content: View {
            modifier(sheetWithDetentsViewModifier(isPresented: isPresented,
                                                  detents: dentents,
                                                  onDismiss: onDismiss,
                                                  content: content)
            )
        }
}
