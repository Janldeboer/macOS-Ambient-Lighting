//
//  SplitListener.swfit.swift
//  Ambilight
//
//  Created by Jan de Boer on 29.07.22.
//

import Foundation

protocol SplitListener {
    func handle(splits: [CGImage])
}
