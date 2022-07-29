//
//  GridPreview.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI

struct GridPreview: View {
    
    @StateObject var splitter: GridSplitter
    //@EnvironmentObject var manager: AmbilightManager
    @State var showIndex = true
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach (0 ..< splitter.config.rows, id:\.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< splitter.config.columns, id:\.self){ column in
                        ZStack() {
                            Rectangle()
                                .scaledToFit()
                                //.foregroundColor(splitter.getColor(x: column, y: row, colors: manager.colors))
                            if showIndex {
                                Text(splitter.getText(x: column, y: row))
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
        GridPreview(splitter: GridSplitter())
    }
}
