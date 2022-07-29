//
//  SplitterView.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI
import CoreData

struct SplitterView: View {
    
    @StateObject var model: GridSplitter
    
    let gridSize: CGFloat = 30
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach (0 ..< model.config.rows, id:\.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< model.config.columns, id:\.self){ column in
                            ZStack() {
                                if let image = model.getImage(row: row, column: column, size: gridSize) {
                                    Image(nsImage: image)
                                    
                                } else {
                                    Rectangle()
                                        .frame(width: gridSize, height: gridSize)
                                        .scaledToFit()
                                    .foregroundColor(model.getColor(row: row, column: column))
                                }
                                Text(model.getText(row: row, column: column))
                                        .foregroundColor(.black)
                                
                            }.frame(minWidth: gridSize, minHeight: gridSize)
                        }
                    }
                }
            }
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text("Rows: ")
                        Spacer()
                        Stepper(value: $model.config.rows, in: ClosedRange.init(uncheckedBounds: (1,50))) {
                            Text("\(model.config.rows)")
                        }
                    }
                    HStack {
                        Text("Columns: ")
                        Spacer()
                        Stepper(value: $model.config.columns, in: ClosedRange.init(uncheckedBounds: (1,50))) {
                            Text("\(model.config.columns)")
                        }
                    }
                }
                VStack (alignment: .leading) {
                    HStack {
                        Text("Start: ")
                        Spacer()
                        Stepper(value: $model.config.startOffset, in: ClosedRange.init(uncheckedBounds: (-1,1000))) {
                            Text("\(model.config.startOffset)")
                        }
                    }
                    HStack {
                        Text("Length: ")
                        Spacer()
                        Stepper(value: $model.config.numberOfParts, in: ClosedRange.init(uncheckedBounds: (1,10000))) {
                            Text("\(model.config.numberOfParts)")
                        }
                    }
                }
            }
            HStack {
                Toggle("Reverse", isOn: $model.config.reverse)
                Toggle("Ignore Black Bar", isOn: $model.config.ignoreBlackBars)
                Spacer()
            }

            Spacer()
        }
    }
}

struct SplitterView_Previews: PreviewProvider {
    static var previews: some View {
        SplitterView(model: GridSplitter())
    }
}

extension GridSplitter {
    func getImage(row:Int, column: Int, size: CGFloat) -> NSImage? {
        let index = self.config.getIndex(row: row, column: column)
        if 0 <= index && index < self.lastSplit.count {
            return NSImage(cgImage: lastSplit[index], size: NSSize(width: size,height: size))
        } else {
            return nil
        }
    }
    
    func getColor(row: Int, column: Int) -> Color {
        let index = self.config.getIndex(row: row, column: column)
        return index == -1 ? .gray : .blue
    }
    
    func getText(row: Int, column: Int) -> String {
        let index = self.config.getIndex(row: row, column: column)
        return index == -1 ? "" : "\(index)"
    }
}
