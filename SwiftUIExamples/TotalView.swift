// Created by Cantero on 08/09/2021.

import SwiftUI

struct TotalView: View {
    
    var additionPrice: UInt? = 0
    
    var body: some View {
        HStack(alignment: .top) {
            Text("Total")
                .font(.body)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                PriceView(price: "\(totalPrice)")
                Text("Aprox. \(String(format: "%.2f", convertToEuros(totalPrice)))€")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .environment(\.sizeCategory, .medium)
            }
        }
        .padding()
    }
    
    var totalPrice: UInt {
        283 + (additionPrice ?? 0)
    }
    
    func convertToEuros(_ amount: UInt) -> Double {
        Double(amount) * 0.846
    }
}

struct TotalView_Previews: PreviewProvider {
    static var previews: some View {
        TotalView()
            .previewAsComponent()
    }
}
