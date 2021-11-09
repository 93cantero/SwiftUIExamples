// Created by Cantero on 31/10/21.

import Combine
import Foundation

protocol PurchaseHeaderViewModel: AnyObject {
    // Wrapped value
    var title: String { get }
    
    // (Published property wrapper)
    var titlePublished: Published<String> { get }
    
    // Publisher
    var titlePublisher: Published<String>.Publisher { get }
    
    var date: String { get }
}

final class PurchaseHeaderViewModelImp: ObservableObject, PurchaseHeaderViewModel {
    
    @Published private(set) var title: String = "RIU Plaza España: terraza 360 rooftop bar + botella"
    var titlePublished: Published<String> { _title }
    var titlePublisher: Published<String>.Publisher { $title }
    @Published private(set) var date: String = "Viernes, 10 Sep"
}
