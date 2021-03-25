//
//  MatrixSplitAmbilightPreview.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import SwiftUI

struct MatrixSplitAmbilightPreview: View, AmbilightOutput {
    
    @Binding var colors: [CGColor]
    var config: MatrixSplitterConfiguration
    
    func outputColors(colors: [CGColor]) {
        self.colors = colors
    }
    
    func getRectangleData(forCoord coord: Coord) -> (Color, String) {
        var color: Color = .black
        var text = ""
        if let i = config.requiredParts.firstIndex(of: coord) {
            if colors.count > i {
                color = Color(colors[i])
                text = "\(i)"
            }
        }
        return (color, text)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach (0 ..< config.numberOfRows, id:\.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< config.numberOfColumns, id:\.self){ column in
                        let coord = Coord(x: column, y: row)
                        let data = getRectangleData(forCoord: coord)
                        ZStack() {
                            Rectangle()
                                .scaledToFit()
                                .foregroundColor(data.0)
                            Text(data.1)
                                .foregroundColor(.black)
                        }.frame(minWidth: 20, minHeight: 20)
                    }
                }
            }
        }
    }
}

struct MatrixSplitAmbilightPreview_Previews: PreviewProvider {
    static var previews: some View {
        MatrixSplitAmbilightPreview(colors: .constant(Examples.simpleMatrixColors()), config: Examples.simpleMatrixSplitterConfig())
    }
}
