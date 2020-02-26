//
//  Avatar.swift
//  GameKit
//
//  Created by Nien Lam on 2/20/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI
//struct MyVariables {
//    static var counter = 0
//}
var counter = 0

struct Avatar: View {
    @Binding var position: CGPoint
    @Binding var flowers: [Flower]
    
    // A variable that keeps the current location before dragging starts.
    @State var offsetBeforeStartOfDrag = CGPoint()
    
    var body: some View {
        
        // Setup drag gesture. Will update binding position.
        let drag = DragGesture(minimumDistance: 0.0, coordinateSpace: CoordinateSpace.global)
            .onChanged { gesture in
                // Update position on drag.
                
                
                self.position = CGPoint(x: self.offsetBeforeStartOfDrag.x + gesture.translation.width,
                                        y: self.offsetBeforeStartOfDrag.y + gesture.translation.height)
                
                // Update all flowers
                // Set hasAvatarEntered to true if we overlap with the flower
                self.flowers = self.flowers.map { flower in
                    let origin = CGPoint(x: flower.position.x - flower.size / 2.0,
                                         y: flower.position.y - flower.size / 2.0)
                    
                    let size = CGSize(width: flower.size, height: flower.size)
                    
                    let boundingBox = CGRect(origin: origin, size: size)
                    // print(boundingBox, self.position)
                    if boundingBox.contains(self.position) {
                        // counter = counter + 1
                        //print(counter)
                        if flower.hasAvatarEntered == false {
                            counter = counter + 1
                            print(counter)
                            
                        }
                        return Flower(id: flower.id, name: flower.name, size: flower.size, hasAvatarEntered: true, position: flower.position)
                    } else {
                        return flower
                    }
                }
        }
        .onEnded { gesture in
            // Remember offset when touch ended.
            self.offsetBeforeStartOfDrag = self.position
        }
        
        return ZStack {
            Image ("watering")
                .resizable()
                .frame(width: 75, height: 75)
            //            Circle()
            //                .fill(Color.red)
            //                .frame(width: 150, height: 150)
            if counter >= 125 {
//                Circle()
//                    .fill(Color.red)
//                    .frame(width: CGFloat(150), height: CGFloat(150))
                // print("you won")
                Text("you won, your garden is beautiful")
                    
                    .font(.custom("Times New Roman", size: 35))
                    .bold()
                    .foregroundColor(Color(red: 252/255, green: 255/255, blue: 204/255))

                    //.background(Color.gray)
                    .frame(width: 250, height: 250)
                //Color(.black)
            }
        }
        .frame(width: 70, height: 70)
        .position(position)
        .animation(.easeInOut(duration: 0.1))
        .gesture(drag)
        .onAppear() {
            // Initialize offset on appear.
            self.offsetBeforeStartOfDrag = self.position
        }
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            Avatar(position: .constant(CGPoint(x: geometry.size.width / 2, y:  geometry.size.height / 2)), flowers: .constant([]))
        }
    }
}
