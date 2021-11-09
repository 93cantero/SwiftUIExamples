// Created by Cantero on 08/09/2021.

import SwiftUI

struct PurchaseAdditionView: View {
//    init() {
//            UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
//            UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
//        }
    @Binding var totalPrice: UInt
//    private var price: UInt = 3
    @State private var value: UInt = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Plant a tree")
                .font(.body)
                .restrictSizeCategory()
                   
            Text("Contibute to plant a tree.")
                .font(.caption)
                .foregroundColor(.secondary)
                .restrictSizeCategory()
                .padding(.bottom, 4)
            
            HStack {
                Stepper(value: $value, in: 0...14, onEditingChanged: { _ in
                    self.totalPrice = 3 * value
                }, label: { Text("x\(value)") })
                .fixedSize()
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    PriceView(price: "\(totalPrice)", decimals: "00", addition: true)
                }
            }
        }
        .padding()
    }
}

struct PurchaseAdditionView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseAdditionView(totalPrice: .mock(0))
            .previewAsComponent()
    }
}
