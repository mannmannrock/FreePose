import SwiftUI
import PhotosUI
struct SocialMediaView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var drawings: [DrawingPost] = [
        DrawingPost(id: UUID(), username: "posemaster1", profileImageName: "profile1", image: UIImage(named: "example1") ?? UIImage(), likes: 12, comments: ["Nice!", "Great work!"]),
        DrawingPost(id: UUID(), username: "sketchqueen", profileImageName: "profile2", image: UIImage(named: "example2") ?? UIImage(), likes: 8, comments: ["Awesome!", "Love this!"])
    ]
    var body: some View {
        VStack(spacing: 0) {
            // ✅ Top Navigation Bar with More Functionality
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(Color(hex: "#450952"))
                        .padding()
                }
                Spacer()
                Text("Free Pose Social")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer()
                Button(action: { /* Notification functionality */ }) {
                    Image(systemName: "bell.fill")
                        .font(.title2)
                        .foregroundColor(Color(hex: "#50d5e7"))
                        .padding()
                }
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 3)
            // ✅ Scrollable Feed
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(drawings.indices, id: \..self) { index in
                        DrawingPostView(drawing: $drawings[index])
                            .frame(maxWidth: 600)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
            }
            .background(Color.white)
            // ✅ Upload Button
            HStack {
                Spacer()
                PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(Color(hex: "#450952"))
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .onChange(of: selectedItem) { _, _ in
            Task {
                if let selectedItem,
                   let data = try? await selectedItem.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {
                    uploadDrawing(image)
                }
            }
        }
    }
    func uploadDrawing(_ image: UIImage) {
        let newDrawing = DrawingPost(id: UUID(), username: "newuser", profileImageName: "profile", image: image, likes: 0, comments: [])
        drawings.insert(newDrawing, at: 0)
    }
}
// ✅ Individual Drawing Post View with Comments
struct DrawingPostView: View {
    @Binding var drawing: DrawingPost
    @State private var isLiked = false
    @State private var animateLike = false
    @State private var commentText = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(drawing.profileImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .shadow(radius: 2)
                Text("@\(drawing.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
            Image(uiImage: drawing.image)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .padding()
                .onTapGesture {
                    isLiked = true
                    drawing.likes += 1
                    withAnimation(Animation.easeOut(duration: 0.5)) {
                        animateLike = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        animateLike = false
                    }
                }
                .overlay(
                    Image(systemName: "heart.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                        .opacity(animateLike ? 1 : 0)
                        .scaleEffect(animateLike ? 1.2 : 0.8)
                )
            HStack {
                Button(action: {
                    isLiked.toggle()
                    drawing.likes += isLiked ? 1 : -1
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                        .font(.title2)
                }
                Text("\(drawing.likes)")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bubble.left.fill")
                        .foregroundColor(Color(hex: "#50d5e7"))
                        .font(.title2)
                }
                Text("\(drawing.comments.count)")
                    .font(.headline)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            // ✅ Comment Section
            VStack(alignment: .leading) {
                ForEach(drawing.comments, id: \..self) { comment in
                    Text(comment)
                        .padding(.vertical, 2)
                        .foregroundColor(.black)
                }
                HStack {
                    TextField("Add a comment...", text: $commentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !commentText.isEmpty {
                            drawing.comments.append(commentText)
                            commentText = ""
                        }
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(Color(hex: "#50d5e7"))
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
struct DrawingPost: Identifiable {
    let id: UUID
    let username: String
    let profileImageName: String
    let image: UIImage
    var likes: Int
    var comments: [String]
}
#Preview(windowStyle: .automatic) {
    SocialMediaView()
}

