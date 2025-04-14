import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var showMenu = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Galaxy background
                Image("GalaxyGB")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                StarField(starCount: 100)

                if showMenu {
                    MainMenuView(showMenu: $showMenu)
                        .transition(.opacity.combined(with: .scale))
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.black.opacity(0.4))
                            .background(.ultraThinMaterial)
                            .blur(radius: 5)
                            .padding()
                            .frame(maxWidth: 520, maxHeight: 540)

                        VStack(spacing: 20) {
                            Image("Logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .shadow(radius: 10)

                            Text("FreePose")
                                .font(.custom("Lato-Bold", size: 50))
                                .foregroundColor(.white)
                                .shadow(radius: 3)

                            Text("Draw Without Limits")
                                .font(.custom("Exo2-Regular", size: 18))
                                .foregroundColor(Color(hex: "#50d5e7"))
                                .multilineTextAlignment(.center)

                            Button(action: {
                                withAnimation {
                                    showMenu = true
                                }
                            }) {
                                Text("Click to Begin")
                                    .font(.custom("Exo2-Bold", size: 18))
                                    .padding()
                                    .frame(width: 200, height: 50)
                                    .background(Color(hex: "#450952"))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    .transition(.opacity.combined(with: .scale))
                }
            }
            .animation(.easeInOut(duration: 0.5), value: showMenu)
        }
    }
}

// MARK: - Main Menu View (Embedded)
struct MainMenuView: View {
    @Binding var showMenu: Bool
    @State private var goToDrawSpace = false
    
    var body: some View {
        ZStack {
            Image("GalaxyGB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            StarField(starCount: 100)

            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.1))
                .background(.ultraThinMaterial)
                .blur(radius: 3)
                .frame(width: 740, height: 540)

            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu = false
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(Color(hex: "#50d5e7"))
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.2)))
                    }
                    Spacer()
                }
                .padding(.horizontal)

                Text("FreePose")
                    .font(.custom("Lato-Bold", size: 42))
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                    .padding(.top, 10)

                // Smaller 3D model with no rotation
                Model3D(named: "BaseMannequin", bundle: realityKitContentBundle)
                    .frame(height: 200) // Reduced size
                    // Removed rotation effect and animation

                VStack(spacing: 20) {
                    NavigationLink(destination: DrawSpace().navigationBarHidden(true), isActive: $goToDrawSpace) {
                        EmptyView()
                    }
                    Button(action: {
                        goToDrawSpace = true
                    }) {
                        MenuRow(icon: "pencil.and.outline", title: "Draw Space")
                    }

                    NavigationLink(destination: GestureDrawingTimerView()) {
                        MenuRow(icon: "timer", title: "Gesture Drawing")
                    }
                    NavigationLink(destination: ResourcesView()) {
                        MenuRow(icon: "paintbrush.pointed.fill", title: "Resources")
                    }
                    NavigationLink(destination: SocialMediaView()) {
                        MenuRow(icon: "person.2.fill", title: "Social Media")
                    }
                }
                Spacer()
            }
            .frame(width: 740, height: 540)
        }
    }
}

// MARK: - Menu Row
struct MenuRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .frame(width: 40)
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "#450952").opacity(0.8)))
        .foregroundColor(.white)
        .shadow(radius: 3)
        .padding(.horizontal, 30)
        .frame(width: 740, height: 700)
    }
}

// MARK: - Starfield
struct StarField: View {
    let starCount: Int

    var body: some View {
        Canvas { context, size in
            for _ in 0..<starCount {
                let x = CGFloat.random(in: 0..<size.width)
                let y = CGFloat.random(in: 0..<size.height)
                let radius = CGFloat.random(in: 0.5...2.0)
                let star = Path(ellipseIn: CGRect(x: x, y: y, width: radius, height: radius))
                context.fill(star, with: .color(.white.opacity(Double.random(in: 0.2...0.9))))
            }
        }
        .ignoresSafeArea()
        .blendMode(.screen)
        .opacity(0.7)
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
#Preview(windowStyle: .automatic) {
    ContentView()
}

