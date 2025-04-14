

import SwiftUI
import RealityKit
import RealityKitContent

struct DuckView: View {
    var body: some View {
        Model3D(named: "Duck", bundle: realityKitContentBundle)
            .padding(.bottom, 50)
            .shadow(radius: 10)
    }
}
