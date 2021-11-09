// Created by Cantero on 8/11/21.

import SwiftUI

struct ArrowButton: View {
    @Binding var opened: Bool
    private var rotationDegrees: Double {
        opened ? 0 : -180
    }
    
    var body: some View {
        Button(action: {
            withAnimation {
                opened.toggle()
            }
        }) {
            Image(systemName: "arrow.up")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.white)
                .padding(.all, 6)
                .rotationEffect(.degrees(rotationDegrees))
        }
    }
}

struct ArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButton(opened: .mock(false))
            .background(Color.green)
            .clipShape(Circle())
            .frame(width: 100, height: 100, alignment: .center)
            .previewAsComponent()
    }
}
