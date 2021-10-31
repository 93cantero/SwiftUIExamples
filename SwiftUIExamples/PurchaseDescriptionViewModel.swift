// Created by Cantero on 31/10/21.

import Combine
import Foundation

final class PurchaseDescriptionViewModel: ObservableObject {
    
    @Published var description: String = """
Reservado + botella Premium (máx. 4 personas) entre las 16:00 y las 18:00 por 240,00€

Tus asientos:

* D15
* D16
* D17
* D18
"""
    
}
