// Created by Cantero on 03/04/2021.

import SwiftUI

struct ItunesSearchView: View {
    
    @ObservedObject var viewModel: ItunesSearchViewModel = ItunesSearchViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchText) {
                viewModel.cancelSearch()
            }
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.models) { item in
                        AppRow(item: item)
                    }
                }
                .animation(.easeIn(duration: 0.3))
            }
            .dismissKeyboardOnDrag()
            .dismissKeyboardOnTap()
        }
        .navigationTitle("ITUNES_SEARCH_TITLE")
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
