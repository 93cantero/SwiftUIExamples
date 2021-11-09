// Created by Cantero on 10/09/2021.

import SwiftUI

struct InvertedBackgroundColor: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        colorScheme == .dark ? Color.white : Color.black
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension Text {
    
    func hiperlinked() -> Text {
        self
            .fontWeight(.bold)
            .foregroundColor(Color.systemGreen)
    }
}

struct PaymentView: View {
    
    var price: UInt
    @State private var displaySheet = false
    
    var body: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                contributeInfo
                applePayButton
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            
            Group {
                Text("Al realizar la compra aceptas las ") +
                Text("Conditiones de Uso")
                    .hiperlinked() +
                Text(" y la ") +
                Text("Política de Privacidad")
                    .hiperlinked() +
                Text(" de la empresa")
            }
            .multilineTextAlignment(.center)
            .font(.caption2)
            .foregroundColor(.secondaryLabel)
            .padding(.leading, 16)
            .padding(.trailing, 16)
            .restrictSizeCategory()
        }
        .padding(.top, 24)
        .padding(.bottom, 24)
        .background(Color.clear)
        .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
        .overlay(
            RoundedCorner(radius: 25, corners: [.topLeft, .topRight])
//                .fill(style: Color.red)
                .stroke(Color.systemGray2)
        )
//        .sheet(isPresented: $displaySheet, content: {
//
//        })
    }
    
    var contributeInfo: some View {
        Button(action: {
        }) {
            Text("Contribución: \(price == 0 ? "" : "+\(price),00 US$")")
                .font(.body)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(4)
        }
        .disabled(true)
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(.white)
        .frame(height: 44, alignment: .center)
        .background(Color.systemGreen)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white)
        )
        .restrictSizeCategory()
    }
    
    var applePayButton: some View {
        Button(action: {
            displaySheet = true
        }) {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: "applelogo")
                    .scaledToFit()
                    .padding(.bottom, 2)
                Text("PAY")
                    .font(Font.custom("HelveticaNeue-Bold", size: 16))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .foregroundColor(.systemBackground)
        .padding()
        .frame(height: 44, alignment: .center)
        .background(InvertedBackgroundColor())
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white)
        )
        .restrictSizeCategory()
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PaymentView(price: 0)
                .frame(width: 375)
                .padding(.top, 50)
                .previewAsComponent()
            PaymentView(price: 0)
                .frame(width: 375)
                .padding(.top, 50)
                .previewAsComponent()
        }
        .background(InvertedBackgroundColor())
    }
}
