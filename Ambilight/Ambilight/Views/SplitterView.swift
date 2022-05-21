//
//  SplitterView.swift
//  Ambilight
//
//  Created by Jan de Boer on 09.03.22.
//

import SwiftUI
import CoreData

struct SplitterView: View {
    
    //@Environment(\.managedObjectContext) private var viewContext
    
    //@FetchRequest(
    //    sortDescriptors: [],
    //    animation: .default)
    //private var grids: FetchedResults<Grid>
    @StateObject var splitter: GridSplitter
    
    var body: some View {
        VStack {
            GridPreview(splitter: splitter)
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
            HStack {
                Toggle("Reverse", isOn: $splitter.config.reverse)
                Toggle("Ignore Black Bar", isOn: $splitter.config.ignoreBlackBars)
                Spacer()
            }

            Spacer()
        }
    }
}

struct SplitterView_Previews: PreviewProvider {
    static var previews: some View {
        SplitterView(splitter: GridSplitter())
    }
}
