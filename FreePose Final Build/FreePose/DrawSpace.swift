import SwiftUI
import RealityKit
import RealityKitContent

struct DrawSpace: View {
    @State private var selectedModelIndex: Int = 0
    @Environment(\.openWindow) var openWindow
    private let modelNames = ["Moai Replica","Wooden Stool", "Wooden Chair", "Sandwich", "Male Anatomy", "Pillars", "Chinese Censer", "BaseMannequin", "Horse", "Duck", "Frog", "Shark"]

    var body: some View {
        NavigationStack {
            ZStack {
                // Galaxy background
                Image("GalaxyGB")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                StarFieldView(starCount: 100)

                VStack(spacing: 10) {
                    HStack {
                        NavigationLink(destination: ContentView()) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(Color(hexColor: "#50d5e7"))
                                .padding(10)
                                .background(Circle().fill(Color.white.opacity(0.2)))
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)

                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.black.opacity(0.4))
                        .background(.ultraThinMaterial)
                        .blur(radius: 5)
                        .padding()
                        .frame(maxWidth: 740, maxHeight: 540)
                        .overlay(
                            VStack(spacing: 20) {
                                Text("Select a Model")
                                    .font(.custom("Lato-Bold", size: 42))
                                    .foregroundColor(.white)
                                    .shadow(radius: 3)

                                TabView(selection: $selectedModelIndex) {
                                    ForEach(0..<modelNames.count, id: \.self) { index in
                                        VStack(spacing: -30) {
                                            Model3D(named: modelNames[index], bundle: realityKitContentBundle)
                                                .frame(height: 280)
                                                .tag(index)

                                            Button {
                                                openWindow(id: "\(modelNames[index])")
                                            } label: {
                                                VStack(spacing: 5) {
                                                    Text("\(modelNames[index])")
                                                        .font(.custom("Exo2-Bold", size: 20))
                                                        .font(.custom("Exo2-Regular", size: 16))
                                                        .foregroundColor(.white.opacity(0.8))
                                                }
                                                .padding()
                                                .frame(width: 250)
                                                .background(Color(hexColor: "#450952"))
                                                .foregroundColor(.white)
                                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                                .shadow(radius: 5)
                                            }
                                        }
                                        .padding(.vertical, 30)
                                    }
                                }
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                .frame(height: 400)
                            }
                            .frame(width: 700)
                        )
                }
            }
        }
    }
}

// MARK: - Starfield View
struct StarFieldView: View {
    let starCount: Int

    var body: some View {
        GeometryReader { geometry in
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
}

// MARK: - Color Extension
extension Color {
    init(hexColor: String) {
        let scanner = Scanner(string: hexColor)
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
    NavigationStack {
        DrawSpace()
    }
}
