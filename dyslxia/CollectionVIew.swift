//
//  ContentView.swift
//  dyslxia
//
//  Created by test on 04.06.19.
//  Copyright © 2019 veit.dev. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentCollectionView : View {
    var body: some View {
        
        List(0 ..< 50) { item in
            MyCollectionView()
                // crash with .infinity
                .frame(width: 300, height: 50)
        }
    }
}

// view inside of the UICollection Cell
struct SmallCVCell : View {
    var body: some View {
        VStack {
            Color.red
                .frame(width: 40, height: 40, alignment: .center)
        }
    }
}


/*
 UIKit:
 Collection view for swift UI style
 */

class MyCoordinator: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}

struct MyCollectionView : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MyCollectionView>) -> UICollectionView {
        // layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // CollectionView
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = .green
        cv.dataSource = context.coordinator
        return cv
    }
    
    func updateUIView(_ uiView: UICollectionView, context: UIViewRepresentableContext<MyCollectionView>) {
        
    }
    
    func makeCoordinator() -> UICollectionViewDataSource {
        let Coordinator = MyCoordinator()
        return Coordinator
    }
    
    typealias UIViewType = UICollectionView
}

class CollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        // adding swift UI to a UIKit view
        let hostingVC = UIHostingController(rootView: SmallCVCell()) // get the view
        
        // add constraints to the view
        addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingVC.view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            hostingVC.view.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            // hight / width contraints have a bug (but are not needed :D )
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
struct ContentCollectionView_Previews : PreviewProvider {
    static var previews: some View {
        ContentCollectionView()
    }
}
#endif
