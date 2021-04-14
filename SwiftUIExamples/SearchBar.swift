// Created by Cantero on 13/04/2021.

import SwiftUI

fileprivate struct RestrictSizeCategory: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory

    func body(content: Content) -> some View {
        Group {
            if sizeCategory > ContentSizeCategory.extraExtraExtraLarge {
                content.transformEnvironment(\.sizeCategory) { value in
                    value = ContentSizeCategory.extraExtraExtraLarge
                }
            } else {
                content
            }
        }
    }
}

extension View {
    func restrictSizeCategory() -> some View {
        return modifier(RestrictSizeCategory())
    }
}

// MARK:-  View

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                    .restrictSizeCategory()
                
                TextField("Search ...", text: $text)

                if isEditing {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                    .restrictSizeCategory()
                    .animation(.easeIn)
                }
            }
            .padding(7)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal)
            .onTapGesture {
                isEditing = true
            }
            .animation(.default)
            
            if isEditing {
                Button("Cancel") {
                    text = ""
                    isEditing = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
                .padding(.trailing)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .mock(""))
            .frame(width: 375)
            .previewAsComponent()
    }
}

extension Binding {
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(get: { value }, set: { value = $0 })
    }
}
