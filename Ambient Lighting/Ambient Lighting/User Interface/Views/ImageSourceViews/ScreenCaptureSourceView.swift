//
//  ScreenCaptureSourceView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import SwiftUI

struct ScreenCaptureSourceView: View {
    @Binding var imageSource: ScreenCapture
    
    var body: some View {
        Picker(selection: $imageSource.display, label: Text("Display")) {
            ForEach(imageSource.getActiveDisplays(), id: \.self) { id in
                Text("Display \(id)")
            }
        }
    }
}


 struct ScreenCaptureSourceView_Previes: PreviewProvider {
    static var previews: some View {
        ScreenCaptureSourceView(imageSource: .constant(ScreenCapture()))
    }
 }
