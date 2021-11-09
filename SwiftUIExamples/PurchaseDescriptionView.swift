// Created by Cantero on 31/10/21.

import SwiftUI

struct PurchaseDescriptionView: View {
    
    internal var opened: Bool
    private var viewModel = PurchaseDescriptionViewModel()
    
    internal init(opened: Bool) {
        self.opened = opened
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if opened {
                LineView()
                    .foregroundColor(.secondary)
                    .transition(.opacity)
                
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .bold()
                    .padding()
                
                    .transition(.opacity)
                    .transition(.move(edge: .bottom))
            }
            
            Rectangle()
                .frame(height: 12.5)
                .foregroundColor(.systemBackground)
        }
    }
}
