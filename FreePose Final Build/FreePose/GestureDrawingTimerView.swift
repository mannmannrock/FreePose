import SwiftUI
import Combine
import AVFoundation
import AudioToolbox
import RealityKit
import RealityKitContent

struct GestureDrawingTimerView: View {
    let poses = [
        "BaseMannequin",
        "Cake",
        "Duck",
        "Frog",
        "Horse",
        "Shark"
    ]

    @State private var currentPose = "BaseMannequin"
    @State private var timer: AnyCancellable?
    @State private var timeRemaining = 30
    @State private var totalTime = 30
    @State private var isTimerRunning = false
    @State private var scale: CGFloat = 1.0
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // Galaxy background
            Image("GalaxyGB")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            StarField(starCount: 100)

            // Frosted card
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white.opacity(0.1))
                .background(.ultraThinMaterial)
                .blur(radius: 3)
                .frame(width: 740, height: 580)

            VStack(spacing: 16) {
                // Back button
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
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

                Text("Gesture Drawing")
                    .font(.custom("Lato-Bold", size: 30))
                    .foregroundColor(.white)
                    .shadow(radius: 3)

                ZStack {
                    ProgressRing(progress: CGFloat(timeRemaining) / CGFloat(max(totalTime, 1)))
                        .frame(width: 220, height: 220)

                    // ✅ Final 3D Model Viewer
                    ModelPoseView(modelName: currentPose, scale: scale)
                        .frame(width: 180, height: 180)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: 0.2), value: scale)
                }

                Text("Time Left: \(timeRemaining)s")
                    .font(.custom("Exo2-Bold", size: 18))
                    .foregroundColor(Color(hex: "#50d5e7"))

                HStack(spacing: 15) {
                    TimerButton(label: "30 Sec") { startTimer(for: 30) }
                    TimerButton(label: "1 Min") { startTimer(for: 60) }
                    TimerButton(label: "2 Min") { startTimer(for: 120) }
                }

                Button("Stop Timer") {
                    stopTimer()
                }
                .font(.custom("Exo2-Bold", size: 16))
                .padding()
                .frame(width: 160)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "#450952")))
                .foregroundColor(.white)
                .shadow(radius: 5)

                Spacer()
            }
            .frame(width: 700, height: 540)
        }
        .onDisappear { stopTimer() }
        .navigationBarHidden(true)
    }

    func startTimer(for duration: Int) {
        stopTimer()
        totalTime = duration
        timeRemaining = duration
        isTimerRunning = true

        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    currentPose = poses.randomElement() ?? poses[0]
                    timeRemaining = duration

                    // Bounce animation
                    scale = 0.9
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        scale = 1.0
                    }

                    // Sound
                    AudioServicesPlaySystemSound(SystemSoundID(1005))
                }
            }
    }

    func stopTimer() {
        timer?.cancel()
        isTimerRunning = false
    }
}

// MARK: - Final Model3D Pose Viewer
struct ModelPoseView: View {
    let modelName: String
    let scale: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.clear)

                Model3D(named: modelName, bundle: realityKitContentBundle) { phase in
                    switch phase {
                    case .success(let model):
                        model
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.9)
                            .scaleEffect(0.3) // adjust as needed
                            .rotation3DEffect(.degrees(10), axis: (x: 1, y: 0, z: 0))
                    default:
                        ProgressView()
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}

// MARK: - Timer Button
struct TimerButton: View {
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.custom("Exo2-Bold", size: 16))
                .padding()
                .frame(width: 100)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(hex: "#450952")))
                .foregroundColor(.white)
                .shadow(radius: 5)
        }
    }
}

// MARK: - Progress Ring
struct ProgressRing: View {
    let progress: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.1), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color(hex: "#50d5e7"), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: progress)
        }
    }
}

// MARK: - Preview
#Preview(windowStyle: .automatic) {
    NavigationStack {
        GestureDrawingTimerView()
    }
}

