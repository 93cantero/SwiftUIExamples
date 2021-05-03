// Created by Cantero on 11/04/2021.
import SwiftUI

struct VTitleAndDescriptionView: View {
    var name: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(name))
                .font(.body)
                .bold()
            Text(LocalizedStringKey(description))
                .font(.caption)
                .lineLimit(3)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}

#if DEBUG
struct VTitleAndDescriptionView_Previews: PreviewProvider {
    
    static var previews: some View {
        VTitleAndDescriptionView(name: "Hello",
                                 description: "This is a long description")
            .previewAsComponent()
    }
}
#endif
