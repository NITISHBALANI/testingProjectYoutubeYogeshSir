//
//  ContentView.swift
//  ShareSheetExtension
//
//  Created by mac on 30/01/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Query private var allItems: [ImageItem]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 15, content: {
                    ForEach(allItems) { item in
                        CardView(item: item)
                            .frame(height: 250)
                    }
                })
                .padding(15)
            }
            .navigationTitle("Favourites")
        }
    }
}

///Card View
struct CardView: View {
    var item: ImageItem
    ///View Properties
    @State private var previewImage: UIImage?
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            if let previewImage {
                Image(uiImage: previewImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
            }else {
                ProgressView()
                    .frame(width: size.width, height: size.height)
                    .task {
                        ///Creating Thumbnail Image
                        Task.detached(priority: .high) {
                            let thumbnail = await UIImage(data: item.data)?.byPreparingThumbnail(ofSize: size)
                            await MainActor.run {
                                previewImage = thumbnail
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
