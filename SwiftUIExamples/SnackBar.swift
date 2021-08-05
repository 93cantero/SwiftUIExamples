// Created by Cantero on 08/06/2021.

import SwiftUI

struct BannerData {
    var title: String
    var detail: String
    var type: BannerType
    var position: BannerPosition = .top
}

enum BannerType {
    case info
    case warning
    case success
    case error
    
    var tintColor: Color {
        switch self {
        case .info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .success:
            return Color.green
        case .warning:
            return Color.yellow
        case .error:
            return Color.red
        }
    }
}

// Edge?
enum BannerPosition {
    case top, bottom
    
    var edge: Edge {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}

struct BannerModifier: ViewModifier {

    @Binding var data: BannerData
    @Binding var show: Bool
    
    @State var task: DispatchWorkItem?
    
    @ViewBuilder
    var bannerContent: some View {
        Text(data.title)
            .bold()
        Text(data.detail)
            .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
    }
    
    @ViewBuilder
    var bannerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                bannerContent
            }
            Spacer()
        }
    }

    func body(content: Content) -> some View {
        ZStack {
            if show {
                VStack {
                    if data.position == .bottom {
                        Spacer()
                    }
                    bannerView
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    .shadow(radius: 20)
                    if data.position == .top {
                        Spacer()
                    }
                }
                .padding()
                .animation(.easeInOut(duration: 0.8))
                .transition(AnyTransition.move(edge: data.position.edge).combined(with: .opacity))
                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear {
                    self.task = DispatchWorkItem {
                        withAnimation {
                            self.show = false
                        }
                    }
                    // Auto dismiss after 5 seconds, and cancel the task if view disappear before the auto dismiss
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.task!)
                }
                .onDisappear {
                    self.task?.cancel()
                }
                .zIndex(1.0)
            }
            content
        }
    }
}

extension View {
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}

struct BannerView_Previews: PreviewProvider {
        
    static var previews: some View {
        MainListView()
            .banner(data: .mock(BannerData(title: "Hola", detail: "Detalle", type: .info)), show: .mock(true))
    }
}

