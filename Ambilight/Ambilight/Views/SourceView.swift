//
//  SourceView.swift
//  Ambilight
//
//  Created by Jan de Boer on 08.03.22.
//

import SwiftUI

struct SourceView: View {
    @StateObject var model: SourceViewModel
    @EnvironmentObject var manager: AmbilightManager
    
    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            ForEach(model.imageSource.getActiveDisplays(), id: \.self) { id in
                VStack(alignment: .center) {
                    ZStack {
                        if let image = model.images[id] {
                            Image(decorative: image, scale: 10)
                                .onTapGesture {
                                    model.imageSource.display = id
                                }
                            if #available(macOS 12.0, *) {
                                if id == model.imageSource.display {
                                    Rectangle()
                                        .foregroundStyle(.clear)
                                        .border(.green, width: 5)
                                        .frame(width: CGFloat(image.width) / 10, height: CGFloat(image.height) / 10, alignment: .center)
                                }
                            }
                        }
                    }
                    Text("Display \(id)")
                }
            }
        }.onReceive(timer, perform: { _ in
            model.refreshImages()
        })
    }
    
    
}

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(model: SourceViewModel(screenCapture: ScreenCapture()))
            .environmentObject(AmbilightManager())
    }
}
