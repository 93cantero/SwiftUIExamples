// Created by Cantero on 03/04/2021.

import SwiftUI

struct ItunesSearchView: View {
    
    @ObservedObject var viewModel: ItunesSearchViewModel = ItunesSearchViewModel()
    
    var body: some View {
        cache = .init()
        return ScrollView {
            LazyVStack {
                ForEach(viewModel.models) { item in
                    AppRow(item: item)
                }
            }
        }
        .navigationTitle("Itunes Search")
        .onAppear {
            viewModel.request()
        }
    }
}

#if DEBUG
struct ItunesSearchView_Previews: PreviewProvider {
    static var previews: some View {
        ItunesSearchView()
            .frame(width: 375)
            .previewAsComponent()
    }
}
#endif
