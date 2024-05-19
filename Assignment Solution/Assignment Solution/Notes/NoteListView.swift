//
//  NoteListView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 20/05/24.
//

import SwiftUI

struct NoteListView: View {
    @Binding var isUserLoggedIn: Bool
    @State private var notes: [Note] = []
    @State private var showingAddNote = false

    var body: some View {
        VStack {
            if let user = UserDefaults.standard.savedUser {
                List(notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note)) {
                        HStack {
                            if let photoData = note.photos.first, let image = UIImage(data: photoData) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            }
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .font(.headline)
                                Text(note.description)
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                .onAppear {
                    notes = UserDefaults.standard.notes(for: user)
                }

                Button("Add Note") {
                    showingAddNote = true
                }
                .padding()
                .sheet(isPresented: $showingAddNote) {
                    AddNoteView(isPresented: $showingAddNote, notes: $notes)
                }

            } else {
                Text("No user logged in.")
            }
        }
        .padding()
        .navigationBarTitle("Notes", displayMode: .inline)
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView(isUserLoggedIn: .constant(true))
    }
}
