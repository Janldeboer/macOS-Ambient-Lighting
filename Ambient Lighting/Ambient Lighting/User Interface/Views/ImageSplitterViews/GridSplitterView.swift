//
//  GridSplitterView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 25.03.21.
//

import SwiftUI

struct GridSplitterView: View {
    
    @Binding var splitter: GridSplitter
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach (0 ..< splitter.config.rows, id:\.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< splitter.config.columns, id:\.self){ column in
                            ZStack() {
                                Rectangle()
                                    .scaledToFit()
                                    .foregroundColor(splitter.getColor(x: column, y: row))
                                Text(splitter.getText(x: column, y: row))
                                    .foregroundColor(.blue)
                            }.frame(minWidth: 20, minHeight: 20)
                        }
                    }
                }
            }
            DisclosureGroup("Settings") {
                VStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                            
                            HStack {
                                Text("Rows: ")
                                Spacer()
                                Stepper(value: $splitter.config.rows, in: ClosedRange.init(uncheckedBounds: (1,50))) {
                                    Text("\(splitter.config.rows)")
                                }
                            }
                            HStack {
                                Text("Columns: ")
                                Spacer()
                                Stepper(value: $splitter.config.columns, in: ClosedRange.init(uncheckedBounds: (1,50))) {
                                    Text("\(splitter.config.columns)")
                                }
                            }
                        }
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Start: ")
                                Spacer()
                                Stepper(value: $splitter.config.startOffset, in: ClosedRange.init(uncheckedBounds: (-1,1000))) {
                                    Text("\(splitter.config.startOffset)")
                                }
                            }
                            HStack {
                                Text("Length: ")
                                Spacer()
                                Stepper(value: $splitter.config.numberOfParts, in: ClosedRange.init(uncheckedBounds: (1,10000))) {
                                    Text("\(splitter.config.numberOfParts)")
                                }
                            }
                        }
                    }
                    Toggle("Reverse", isOn: $splitter.config.reverse)
                }
            }
        }
    }
}

/*
struct GridPreview_Previews: PreviewProvider {
    static var previews: some View {
        GridSplitterView()
    }
}
*/
