// Created by Cantero on 06/06/2021.

import SwiftUI

extension BannerData {
    static let success = BannerData(title: "Success!", detail: "This is a success message!",
                                    type: .info)
    static let error = BannerData(title: "Error!", detail: "This is an error message!",
                                    type: .error)
}

class SnackManager: ObservableObject {
    
    @Published var data: BannerData = .success
    @Published var display: Bool = false
    
    func newSnack(data: BannerData) {
        self.data = data
        self.display = true
    }
}

class ModalManager: ObservableObject {
    
    @Published var modal: Modal = Modal(position: .closed, content: nil)
    
    func newModal<Content: View>(position: ModalState, @ViewBuilder content: () -> Content ) {
        modal = Modal(position: position, content: AnyView(content()))
    }
    
    func openModal() {
        modal.position = .partiallyRevealed
    }
    
    func closeModal() {
        modal.position = .closed
    }
}
