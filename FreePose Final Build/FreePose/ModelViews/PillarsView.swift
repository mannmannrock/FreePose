//
//  PillarsView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 4/10/25.
//


import SwiftUI
import RealityKit
import RealityKitContent

struct PillarsView: View {
    var body: some View {
        Model3D(named: "Pillars", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}

