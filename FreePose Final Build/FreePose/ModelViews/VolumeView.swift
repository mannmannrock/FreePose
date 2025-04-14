//
//  ContentView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 2/17/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct VolumeView: View {
    var body: some View {
        Model3D(named: "Scene", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}
