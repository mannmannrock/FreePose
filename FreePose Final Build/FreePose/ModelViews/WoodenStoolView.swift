//
//  WoodenStoolView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 4/10/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct WoodenStoolView: View {
    var body: some View {
        Model3D(named: "Wooden Stool", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}
