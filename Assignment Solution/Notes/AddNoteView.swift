//
//  AddNoteView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI
import PhotosUI

struct AddNoteView: View {
    @Binding var isPresented: Bool
    @Binding var notes: [Note]
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var photos: [Data] = []
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var errorMessage: String?
    @State private var cameraAlert = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Note Title")) {
                    TextField("Enter title", text: $title)
                        .autocapitalization(.words)
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 150)
                }
                
                Section(header: Text("Photos")) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(photos, id: \.self) { photoData in
                                if let image = UIImage(data: photoData) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                        .padding(4)
                                }
                            }
                            if photos.count < 10 {
                                Button(action: {
                                    showingImagePicker = true
                                }) {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                        .padding(4)
                                }
                                
                                Button(action: {
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        showingCamera = true
                                    } else {
                                        cameraAlert = true
                                    }
                                }) {
                                    Image(systemName: "camera")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                        .padding(4)
                                }
                                .alert(isPresented: $cameraAlert) {
                                    Alert(title: Text("Camera not available"),
                                          message: Text("The camera is not available on this device."),
                                          dismissButton: .default(Text("OK")))
                                }
                            }
                        }
                    }
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button("Save") {
                    saveNote()
                }
                .disabled(!isValidNote)
            }
            .navigationTitle("Add Note")
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            })
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(images: $photos)
            }
            .sheet(isPresented: $showingCamera) {
                CameraPicker(images: $photos)
            }
        }
    }

    private var isValidNote: Bool {
        title.count >= 5 && title.count <= 100 &&
        description.count >= 100 && description.count <= 1000
    }

    private func saveNote() {
        guard let user = UserDefaults.standard.savedUser else {
            errorMessage = "No user logged in."
            return
        }

        let newNote = Note(id: UUID(), title: title, description: description, photos: photos)
        var currentNotes = UserDefaults.standard.notes(for: user)
        currentNotes.append(newNote)
        UserDefaults.standard.save(notes: currentNotes, for: user)
        notes = currentNotes
        isPresented = false
    }
}
