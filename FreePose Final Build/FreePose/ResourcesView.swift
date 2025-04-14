import SwiftUI
struct ResourcesView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            // Galaxy background + stars
            Image("GalaxyGB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            StarField(starCount: 100)
            // Frosted backdrop
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.1))
                .background(.ultraThinMaterial)
                .blur(radius: 3)
                .frame(width: 900, height: 640 )
            VStack(alignment: .leading, spacing: 20) {
                // Back button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color(hex: "#50d5e7"))
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.2)))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                Text("Resources")
                    .font(.custom("Lato-Bold", size: 34))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                ScrollView {
                    VStack(spacing: 30) {
                        ResourceSection(title: "Drawing Tutorials", resources: [
                            ("Figure Draw Tutorial", "https://ramstudioscomics.com/index.php/2023/10/27/how-to-draw-the-figure-with-basic-forms/", "Figure_Draw")
                        ])
                        ResourceSection(title: "Gesture Exercises", resources: [
                            ("Gesture Drawing Videos", "https://www.youtube.com/results?search_query=gesture+drawing", "Gesture_Drawing"),
                            ("Practice Tool", "https://line-of-action.com/practice-tools/figure-drawing", "Practice_Tool")
                        ])
                        ResourceSection(title: "Pose References", resources: [
                            ("Free Pose References", "https://www.posemaniacs.com", "Pose_References")
                        ])
                    }
                    .padding(.horizontal, 25)
                }
                Spacer()
            }
            .frame(width: 720, height: 560)
        }
        .navigationBarHidden(true)
    }
}
// MARK: - Resource Section
struct ResourceSection: View {
    let title: String
    let resources: [(String, String, String)]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.custom("Exo2-Bold", size: 20))
                .foregroundColor(.white)
                .padding(.leading, 5)
            VStack(spacing: 15) {
                ForEach(resources, id: \.0) { resource in
                    NavigationLink(destination: ResourceDetailView(title: resource.0, url: resource.1, imageName: resource.2)) {
                        ResourceLink(title: resource.0, imageName: resource.2)
                    }
                }
            }
        }
    }
}
// MARK: - Resource Link Card
struct ResourceLink: View {
    let title: String
    let imageName: String
    var body: some View {
        HStack(spacing: 15) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 55, height: 55)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 3)
            Text(title)
                .font(.custom("Exo2-Regular", size: 16))
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "arrow.right.circle.fill")
                .font(.title2)
                .foregroundColor(Color(hex: "#50d5e7"))
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 4)
    }
}
// MARK: - Detail View
struct ResourceDetailView: View {
    let title: String
    let url: String
    let imageName: String
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Image("GalaxyGB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            StarField(starCount: 80)
            // Frosted gradient box
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.1))
                .background(.ultraThinMaterial)
                .blur(radius: 3)
                .frame(width: 900, height: 640)
            VStack(spacing: 20) {
                // Top Bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color(hex: "#50d5e7"))
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.2)))
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                Text(title)
                    .font(.custom("Lato-Bold", size: 30))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 6)
                    .padding()
                Button(action: {
                    if let link = URL(string: url) {
                        UIApplication.shared.open(link)
                    }
                }) {
                    Text("Visit Resource")
                        .font(.custom("Exo2-Bold", size: 16))
                        .padding()
                        .frame(width: 220)
                        .background(RoundedRectangle(cornerRadius: 25).fill(Color(hex: "#450952")))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                Spacer()
            }
            .frame(width: 700, height: 540)
        }
        .navigationBarHidden(true)
    }
}
#Preview(windowStyle: .automatic) {
    NavigationStack {
        ResourcesView()
    }
}


