//
//  MainView.swift
//  Assignment Solution
//
//  Created by Aryan Sharma on 19/05/24.
//

import SwiftUI

struct MainView: View {
    @State private var isUserLoggedIn = false

    var body: some View {
        NavigationView {
            if isUserLoggedIn {
                NoteListView(isUserLoggedIn: $isUserLoggedIn)
            } else {
                LoginView(isUserLoggedIn: $isUserLoggedIn)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

