//
//  CollisionObject.swift
//  GameKit
//
//  Created by Nien Lam on 2/20/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct CollisionObject: View {
    var imgUrl: String
    var hasAvatarEntered: Bool

    var body: some View {
        Image(imgUrl)
            .resizable()
            .opacity(hasAvatarEntered ? 1.0 : 0.0)
    }
}

struct CollisionObject_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            CollisionObject(
                imgUrl: "poppy",
                hasAvatarEntered: false
            )
        }
    }
}
