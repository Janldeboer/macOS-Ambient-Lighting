//
//  GridPreview.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI

struct GridPreview: View {
    
    @StateObject var model: GridPreviewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach (0 ..< model.rows, id:\.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< model.columns, id:\.self){ column in
                        ZStack() {
                            Rectangle()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .foregroundColor(model.getColor(row: row, column: column))
                            if model.showIndex {
                                Text(model.getText(row: row, column: column))
                                    .foregroundColor(.black)
                            }
                        }.frame(minWidth: 20, minHeight: 20)
                    }
                }
            }
        }
    }
}

struct GridPreview_Previews: PreviewProvider {
    static var previews: some View {
        GridPreview(model: GridPreviewModel(splitter: GridSplitter()))
    }
}
