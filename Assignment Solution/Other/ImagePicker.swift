//
//  ImagePicker.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [Data]
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()

            for result in results {
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                        guard let url = url else {
                            print("Failed to load file representation: \(error?.localizedDescription ?? "Unknown error")")
                            return
                        }

                        do {
                            let data = try Data(contentsOf: url)
                            DispatchQueue.main.async {
                                self.parent.images.append(data)
                            }
                        } catch {
                            print("Failed to convert file to data: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("Can't load image")
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}
