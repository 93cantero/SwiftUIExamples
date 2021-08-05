//  Created by Cantero on 20/03/2021.

import SwiftUI

struct MenuDetail: View {
    
    @EnvironmentObject var modalManager: ModalManager
    @EnvironmentObject var snackManager: SnackManager
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                ModalAnchorView()
                Text("Detail")
                VStack {
                    Button("Open Modal") {
//                        self.modalManager.openModal()
                        self.snackManager.newSnack(data: .success)
                    }
                }
                .onAppear {
                    self.modalManager.newModal(position: .closed) {
                        Text("Modal Content")
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("Detail")
    }
}

struct MainListView: View {
    
    var menuItems = MenuItem.allCases
    @StateObject var snackManager = SnackManager()
    
    var body: some View {
        NavigationView {
            List(menuItems) { item in
                NavigationLink(destination: item.destination) {
                    MenuRow(item: item)
                }
            }
            .navigationTitle("Menu")
            .listStyle(GroupedListStyle())
        }
        .environmentObject(snackManager)
        .banner(data: $snackManager.data, show: $snackManager.display)
        .environmentObject(ModalManager())
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}

