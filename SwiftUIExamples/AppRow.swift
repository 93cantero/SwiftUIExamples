// Created by Cantero on 31/03/2021.

import SwiftUI

struct AppRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top) {
                Color.red
                    .foregroundColor(Color(UIColor.label))
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading, spacing: 8) {
                    Text("App Name")
                        .font(.body)
                        .bold()
                    Text("Description Descriptionasdasdadasd Descriptiosdsadn Description Description  Description Description Description")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    HStack(alignment: .center, spacing: 8) {
                        ForEach(values: 0...5) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(Color.orange)
                        }
                        Text("(4.5)")
                            .font(.caption2)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
                .layoutPriority(1)
                
                
                Spacer()
                
                Image(systemName: "icloud.and.arrow.down.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .padding(.top, 12)
                    .font(.caption)
                    .frame(width: 25)
                    .onTapGesture {
                        print("Pressed download")
                    }
            }
            
            LazyVGrid(columns: [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())],
                      alignment: .center, spacing: 12) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.green)
                    .frame(height: 250)
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.blue)
                    .frame(height: 250)
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.yellow)
                    .frame(height: 250)
            }
            .font(.body)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

struct AppRow_Previews: PreviewProvider {
    static var previews: some View {
        AppRow()
            .frame(width: 375)
            .previewAsComponent()
    }
}
