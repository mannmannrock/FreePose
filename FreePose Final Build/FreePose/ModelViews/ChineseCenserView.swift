//
//  BaseMannequinView.swift
//  FreePose
//
//  Created by Mann Sy Tha on 3/18/25.
//



import SwiftUI
import RealityKit
import RealityKitContent

struct ChineseCenserView: View {
    var body: some View {
        Model3D(named: "Chinese Censer", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}

