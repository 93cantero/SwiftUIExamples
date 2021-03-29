//  Created by Cantero on 20/03/2021.

import SwiftUI

struct MenuDetail: View {
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("Detail")
                Spacer()
            }
        }
        .navigationTitle("Detail")
    }
}

struct MainListView: View {
    
    var menuItems = MenuItem.allCases
    
    var body: some View {
        NavigationView {
            List(menuItems) { item in
                NavigationLink(destination: MenuDetail()) {
                    MenuRow(item: item)
                }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}

