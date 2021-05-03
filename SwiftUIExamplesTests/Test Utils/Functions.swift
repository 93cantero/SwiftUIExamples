// Created by Cantero on 03/05/2021.

import UIKit

func delay(_ seconds: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}
