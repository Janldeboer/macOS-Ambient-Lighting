//
//  ImageSplitterView.swift
//  Ambient Lighting
//
//  Created by Jan de Boer on 04.09.21.
//

import SwiftUI

struct ImageSplitterView: View {
    
    @Binding var splitter: ImageSplitter?
    @Binding var colors: [CGColor]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20
            )
                .shadow(radius: 10)
                .foregroundColor(.init(red: 0.3, green: 0.3, blue: 0.3))
            VStack {
                if splitter == nil {
                    Button("Add Grid Splitter") {
                        splitter = GridSplitter()
                    }.padding()
                } else {
                    
                    DisclosureGroup(content: {
                        if splitter is GridSplitter {
                            let bind = Binding<GridSplitter>(get: { splitter as! GridSplitter}, set: { splitter = $0})
                            GridSplitterView(splitter: bind, colors: _colors)
                                .padding([.top])
                            
                        }
                    }, label: {
                        HStack {
                            Text(splitter!.description)
                                .font(.title)
                                .padding(.leading)
                            Spacer()
                            Image("Delete")
                                .onTapGesture {
                                    splitter = nil
                                }
                        }
                    })
                        .padding()
                }
            }
        }
    }
}

struct ImageSplitterView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSplitterView(splitter: .constant(GridSplitter()), colors: .constant([]))
    }
}
