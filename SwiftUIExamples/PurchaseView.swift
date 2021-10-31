// Created by Cantero on 05/08/2021.

import SwiftUI

struct PurchaseView: View {
    
    @ObservedObject var viewModel = PurchaseViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    PurchaseHeaderView()
                    PurchaseAdditionView(totalPrice: $viewModel.additionPrice)
                    LineView()
                        .foregroundColor(.secondary)
                    TotalView(additionPrice: viewModel.additionPrice)
                }
            }
            Spacer()
            PaymentView(price: viewModel.additionPrice)
        }
//        .background(Color.secondarySystemBackground)
        .navigationBarTitle("Hola", displayMode: .inline)
    }
}

#if DEBUG
struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
//            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .previewAsSeparateColorSchemes()
    }
}
#endif
