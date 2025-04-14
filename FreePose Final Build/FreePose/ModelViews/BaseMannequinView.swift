//
//  BaseMannequinView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 3/18/25.
//



import SwiftUI
import RealityKit
import RealityKitContent

struct BaseMannequinView: View {
    var body: some View {
        Model3D(named: "BaseMannequin", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}

