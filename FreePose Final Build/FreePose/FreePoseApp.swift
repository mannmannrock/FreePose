import SwiftUI
import RealityKit
import RealityKitContent
@main
struct FreePoseApp: SwiftUI.App {  // Explicitly specify SwiftUI.App
    @State private var appModel = AppModel()
    
    var body: some SwiftUI.Scene {  // Explicitly specify SwiftUI.Scene
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
 
        //VOLUME WINDOW OBJECTS
        WindowGroup(id: "Scene") {//Calls specific Volume HERE, needs to respond to all
            VolumeView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        WindowGroup(id: "BaseMannequin") {//Calls specific Volume HERE, needs to respond to all
            BaseMannequinView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        WindowGroup(id: "Duck") {//Calls specific Volume HERE, needs to respond to all
            DuckView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        WindowGroup(id: "Horse") {//Calls specific Volume HERE, needs to respond to all
            HorseView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Shark") {//Calls specific Volume HERE, needs to respond to all
            SharkView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Frog") {//Calls specific Volume HERE, needs to respond to all
            FrogView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        //LATEST BATCH
        
        WindowGroup(id: "Chinese Censer") {//Calls specific Volume HERE, needs to respond to all
            ChineseCenserView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Moai Replica") {//Calls specific Volume HERE, needs to respond to all
            MoaiReplicaView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Wooden Stool") {//Calls specific Volume HERE, needs to respond to all
            WoodenStoolView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Wooden Chair") {//Calls specific Volume HERE, needs to respond to all
            WoodenChairView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Male Anatomy") {//Calls specific Volume HERE, needs to respond to all
            MaleAnatomyView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Sandwich") {//Calls specific Volume HERE, needs to respond to all
            SandwichView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        WindowGroup(id: "Pillars") {//Calls specific Volume HERE, needs to respond to all
            PillarsView()
                .environment(appModel)
        }
        .windowStyle(.volumetric) // Ensure it is used properly
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
