//
//  ImageListener.swift
//  Ambilight
//
//  Created by Jan de Boer on 31.05.22.
//

import Foundation

protocol ImageListener {
    func handle(image: CGImage)
}
