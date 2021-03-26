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
    let serialPortPath: String = "/dev/cu.usbmodem1301"
    let matrixSplitterConfig: MatrixSplitterConfiguration = Examples.getBigMatrixSplitterConfig()
    let correction: ColorCorrection = Examples.getChainedCorrection()
    
    let imageSource = ScreenCapture()
    let imageSplitter: MatrixSplitter
    let imageReducer = ScalingReduction()
    let creator: AmbientLightingCreator
    let output = SerialOutput()
    
    @State var colors: [CGColor] = []
    
    init() {
        imageSplitter = MatrixSplitter(config: matrixSplitterConfig)
        creator = AmbientLightingCreator(imageSplitter: imageSplitter, imageReduction: imageReducer, colorCorrection: correction)
        
        output.selectPort(withPath: serialPortPath)
        output.setBaudRate(baudRate: 230400)
        output.openPort()
    }
    
    var body: some View {
        MatrixSplitPreview(colors: $colors, config: matrixSplitterConfig)
            .onReceive(timer, perform: { _ in
                let img = imageSource.getImage()
                colors = creator.getUncorrectedColors(forImage: img)
                output.outputColors(colors: creator.getColors(forImage: img))
            })
    }
    
}

struct AmbientLightingPreview_Previews: PreviewProvider {
    static var previews: some View {
        AmbientLightingPreview()
    }
}
