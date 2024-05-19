//
//  NoteDetailView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                
                ForEach(note.photos, id: \.self) { photoData in
                    if let image = UIImage(data: photoData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 5)
                    }
                }
                
                Text(note.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Note Details")
    }
}

