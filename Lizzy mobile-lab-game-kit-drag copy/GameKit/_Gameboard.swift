//
//  _Gameboard.swift
//  GameKit
//
//  Created by Elizabeth Chiappini on 2/25/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI
//var counter = 0

struct Flower {
    static var names = [
        "marigold",
        "poppy",
        "violet",
        "cosmo",
       // "dahlia",
        "worm",
    ]
    
    static func randomFlowerName() -> String {
        let index = Int.random(in: 0..<Flower.names.count)
        return names[index]
    }
    
    static func randomFlowerSize() -> CGFloat {
        return CGFloat.random(in: 40...60)
    }
    
    var id: String = UUID().uuidString
    
    // Automatically assign these
    var name: String = Flower.randomFlowerName()
    var size: CGFloat = Flower.randomFlowerSize()
    
    // Assign this later
    var hasAvatarEntered: Bool = false
    var position: CGPoint
    
   // MyVariables.counter  = MyVariables.counter + 1
    
    
   // counter = counter+1
   // print(counter)
}


struct  _GameBoard: View {
    var numFlowers = 150
    @Binding var avatarPosition: CGPoint
    @State var flowers: [Flower] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(self.flowers, id: \Flower.id) { flower in
                    CollisionObject(
                        imgUrl: flower.name,
                        hasAvatarEntered: flower.hasAvatarEntered
                    )
                        .frame(width: flower.size, height: flower.size)
                        .position(flower.position)
                }
                
                // Place avatar
                Avatar(position: self.$avatarPosition, flowers: self.$flowers)
            }.onAppear() {
                
                self.flowers = Array(0..<self.numFlowers).map { index in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let x = CGFloat.random(in: 0...width)
                    let y = CGFloat.random(in: 0...height)
                    let position = CGPoint(x: x, y: y)
                    return Flower(position: position)
                }
            }
        }
    }
}


struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            _GameBoard(avatarPosition: .constant(CGPoint()))
        }
    }
}

