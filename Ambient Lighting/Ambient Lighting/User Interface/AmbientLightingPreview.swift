//
//  AmbientLightingPreview.swift
//  Screen Analyzer
//
//  Created by Jan de Boer on 25.03.21.
//

import SwiftUI

struct AmbientLightingPreview: View {
    
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    /// Change these to parametes to match your setup
    let serialPortPath: String = "/dev/cu.usbmodem11301"
    let matrixSplitterConfig: MatrixSplitterConfiguration = Examples.getBigMatrixSplitterConfig()
    
    let imageSource = ScreenCapture()
    let imageSplitter: MatrixSplitter
    let imageReducer = ScalingReduction()
    let creator: AmbilightCreator
    let output = SerialOutput()
    
    @State var colors: [CGColor] = []
    
    init() {
        imageSplitter = MatrixSplitter(config: matrixSplitterConfig)
        creator = AmbilightCreator(imageSplitter: imageSplitter, imageReduction: imageReducer, colorCorrection: nil)
        
        output.selectPort(withPath: "/dev/cu.usbmodem11301")
        output.setBaudRate(baudRate: 230400)
        output.openPort()
    }
    
    var body: some View {
        
        MatrixSplitAmbilightPreview(colors: $colors, config: matrixSplitterConfig)
            .onReceive(timer, perform: { _ in
                colors = creator.getColors(forImage: imageSource.getImage())
                output.outputColors(colors: colors)
            })
    }
    
}

struct AmbilightPreview_Previews: PreviewProvider {
    static var previews: some View {
        AmbientLightingPreview()
    }
}
