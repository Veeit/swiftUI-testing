//
//  ContentView.swift
//  dyslxia
//
//  Created by test on 04.06.19.
//  Copyright © 2019 veit.dev. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        List(0 ..< 50) { item in
            SmallCell(index: item)
        }
    }
}

struct view: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var alpha: CGFloat
    var action: () -> Void
    
    func makeUIView(context: UIViewRepresentableContext<view>) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        let pressRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(recognizer:)))
        view.addGestureRecognizer(pressRecognizer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<view>) {
        context.coordinator.action = action
        uiView.alpha = alpha
    }
    
    func makeCoordinator() -> view.Coordinator {
        return Coordinator()
    }
    
    class Coordinator {
        var action: () -> Void = {}
        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            action()
        }
    }
}

struct SmallCell : View {
    var index: Int
    @State private var showModal: Bool = false
    
    var body: some View {
        VStack {
            view(alpha: CGFloat(index) / 50.0, action: {
                self.showModal.toggle()
            })
            }.presentation(modalPresentation)
    }
    
    var modalPresentation: Modal? {
        guard showModal else { return nil }
        
        return Modal(Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)) {
            print("dismiss")
            
        }
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
