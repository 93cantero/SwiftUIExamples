// Created by Cantero on 13/04/2021.

import SwiftUI
import Combine

// MARK:-  View

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing: Bool = false
    var onCancel: (() -> Void)?
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .restrictSizeCategory()
                TextField("SEARCH_BAR_TITLE".localized, text: $text)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        withAnimation {
                            isEditing = true
                        }
                    }

                if isEditing {
                    makeClearButton()
                }
            }
            .padding(7)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal)
            
            if isEditing {
                makeCancelButton()
            }
        }
    }
}

extension SearchBar {
    
    func makeClearButton() -> some View {
        Button(action: {
            text = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .restrictSizeCategory()
    }
    
    func makeCancelButton() -> some View {
        Button("SEARCH_BAR_BUTTON_CANCEL") {
            text = ""
            withAnimation {
                isEditing = false
            }
            UIApplication.shared.endEditing()
            onCancel?()
        }
        .padding(.trailing)
        .transition(.move(edge: .trailing))
    }
}

// MARK: - Previews

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .mock(""))
            .frame(width: 375)
            .previewAsComponent()
            .translated(to: .es)
    }
}
