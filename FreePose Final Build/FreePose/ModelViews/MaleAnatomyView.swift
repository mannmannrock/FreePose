//
//  MaleAnatomyView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 4/10/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MaleAnatomyView: View {
    var body: some View {
        Model3D(named: "Male Anatomy", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}
