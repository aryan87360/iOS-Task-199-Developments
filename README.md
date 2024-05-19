# Password Manager App for iOS

## Prerequisites
- A MacOS-supported computer.
- MacOS Monterey or later installed.

## Getting Started

### Step 1: Install Xcode
- Download and install Xcode from the App Store or Apple Developer website (https://developer.apple.com).

### Step 2: Clone the Repository
- Clone this repository to your local machine using the following command in Terminal:
git clone https://github.com/aryan87360/iOS-Task-199-Developments

### Step 3: Open the Project
- Navigate to the cloned repository's directory and open the project in Xcode:
- cd path/to/repository open -a Xcode .

### Step 4: Prepare for Launch
- Wait for Xcode to finish indexing the project files.
- Choose an iPhone model in the simulator or connect a physical iPhone to your Mac.
- **Note:** For a physical device, ensure that the developer option is enabled.

### Step 5: Run the Application
- Click on the 'Run' icon to start the application in the selected environment.



Notes App Documentation

Overview

The Notes App is an iOS application built using SwiftUI that allows users to create and manage notes. Each note consists of a title, a description, and optional photos. Users can add photos either from their photo library or by taking a new photo using the camera.

Features

1. Create Notes: Users can create notes with a title, description, and up to 10 photos.
2. View Notes: Users can view the list of their notes.
3. Photo Integration: Users can add photos to their notes from the photo library or the camera.
4. Persistent Storage: Notes are saved using UserDefaults for persistent storage.
5. Validation: Notes must have a title (5-100 characters) and a description (100-1000 characters) before they can be saved.
6. Error Handling: The app displays appropriate error messages when necessary, such as when the user is not logged in or when the camera is unavailable.

Components

1. Models

2. Views

* AddNoteView: View for adding a new note.
    * Title Section: Text field for entering the note's title.
    * Description Section: Text editor for entering the note's description.
    * Photos Section: Allows users to add photos from their library or camera.
    * Save Button: Validates and saves the note.
    * Cancel Button: Dismisses the view without saving.

* ImagePicker: View for picking images from the photo library.
* CameraPicker: View for capturing images using the camera.

3. Storage

* UserDefaults: Custom extension to save and retrieve notes.

User Flow

1. Launch App: User launches the app.
2. Add Note: User navigates to the Add Note screen.
3. Enter Details: User enters the title and description of the note.
4. Add Photos: User adds photos either from the photo library or by taking new photos with the camera.
5. Save Note: User saves the note, which is then stored in UserDefaults.
6. View Notes: User can view the list of saved notes.

Error Handling

* No User Logged In: Displays an error message if no user is logged in.
* Camera Unavailable: Displays an alert if the camera is not available on the device.

Conclusion
The Notes App is a simple yet powerful tool for managing notes with photo integration. The use of SwiftUI makes the UI development intuitive and modern, while UserDefaults provides a lightweight solution for data persistence. The app handles common scenarios like unavailable camera gracefully, ensuring a smooth user experience.
