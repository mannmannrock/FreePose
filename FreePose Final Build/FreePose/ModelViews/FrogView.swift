//
//  FrogView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 2/19/25.
//



import SwiftUI
import RealityKit
import RealityKitContent

struct FrogView: View {
    var body: some View {
        Model3D(named: "Frog", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}
