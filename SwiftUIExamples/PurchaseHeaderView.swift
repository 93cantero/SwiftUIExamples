// Created by Cantero on 05/08/2021.

import SwiftUI

struct PurchaseHeaderView: View {
    
    @State var opened: Bool = false
    private(set) var viewModel: PurchaseHeaderViewModel = PurchaseHeaderViewModelImp()
    private var rotationDegrees: Double {
        opened ? 0 : -180
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(.body)
                        Text(viewModel.date)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                            .truncationMode(/*@START_MENU_TOKEN@*/.middle/*@END_MENU_TOKEN@*/)
                            .minimumScaleFactor(0.7)
                    }
                    
                    Spacer()
                    PriceView()
                }
                .padding()
                
                
                PurchaseDescriptionView(opened: opened)
            }
                
            ZStack {
                if !opened {
                    Group {
                        Spacer()
                        LineView()
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                
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
                .background(Color.green)
                .clipShape(Circle())
                .frame(width: 24, height: 24, alignment: .center)
            }
        }
    }
}

struct PurchaseHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PurchaseHeaderView()
                .frame(width: 375)
                .fixedSize()
            
            PurchaseHeaderView(opened: true)
                .frame(width: 375)
                .fixedSize()
        }
        .previewAsComponent()
    }
}
