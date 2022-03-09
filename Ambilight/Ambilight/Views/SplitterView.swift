//
//  SplitterView.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI

struct SplitterView: View {
    
    @StateObject var model: SplitterViewModel = SplitterViewModel()
    
    @EnvironmentObject var manager: AmbilightManager
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach (0 ..< model.config.rows, id:\.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< model.config.columns, id:\.self){ column in
                            ZStack() {
                                Rectangle()
                                    .scaledToFit()
                                    .foregroundColor(model.getColor(x: column, y: row, colors: manager.colors))
                                Text(model.getText(x: column, y: row))
                                    .foregroundColor(.black)
                            }.frame(minWidth: 20, minHeight: 20)
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
        SplitterView()
    }
}
