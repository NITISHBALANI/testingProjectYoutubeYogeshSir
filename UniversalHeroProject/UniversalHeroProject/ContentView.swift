//
//  ContentView.swift
//  UniversalHeroProject
//
//  Created by mac on 30/06/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            List(items) { item in
                CardView(item: item)
            }
            .navigationTitle("Hero Effect")
        }
    }
}

#Preview {
    ContentView()
}
///Card View
struct CardView: View {
    var item: Item
    ///View Properties
    @State private var expandSheet: Bool = false
    var body: some View {
        HStack(spacing: 12, content: {
            SourceView(id: item.id.uuidString) {
                imageView()
            }
            Text(item.title)
            Spacer(minLength: 0)
        })
        .contentShape(.rect)
        .onTapGesture {
            expandSheet.toggle()
        }
        .sheet(isPresented: $expandSheet, content: {
            DestinationView(id: item.id.uuidString) {
               imageView()
                    .onTapGesture {
                        expandSheet.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .interactiveDismissDisabled()
        })
        .heroLayer(id: item.id.uuidString, animate: $expandSheet) {
           imageView()
        } completion: { status in
            print(status ? "Open": "Close")
        }
    }
    @ViewBuilder
    func imageView() -> some View {
        Image(systemName: item.symbol)
            .font(.title2)
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(item.color.gradient, in: .circle)
    }
}

///Demo Item Model
struct Item: Identifiable {
    var id: UUID = .init()
    var title: String
    var color: Color
    var symbol: String
}
var items: [Item] = [
    .init(title: "Book Icon", color: .red, symbol: "book.fill"),
    .init(title: "Stack Icon", color: .blue, symbol: "square.stack.3d.up"),
    .init(title: "Rectangle Icon", color: .orange, symbol: "rectangle.portrait")
]
