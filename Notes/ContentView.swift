//
//  ContentView.swift
//  Notes
//
//  Created by Joseph Smith on 11/17/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @StateObject var noteApp = NoteViewModel()
    @State var note = NoteModel(title: "", notesdata: "")
    @State var isSignedIn = Auth.auth().currentUser != nil 
    
    var body: some View {
        if isSignedIn {
            NavigationStack {
                VStack {
                    List {
                        ForEach($noteApp.notes) { $note in
                            NavigationLink {
                                NoteDetail(note: $note)
                            } label: {
                                Text(note.title)
                            }
                        }
                        Section {
                            NavigationLink {
                                NoteDetail(note: $note)
                            } label: {
                                Text("New Note")
                                    .foregroundColor(Color.gray)
                                    .font(.system(size: 15))
                            }
                        }
                    }
                    .onAppear {
                        noteApp.fetchhData()
                    }
                    .refreshable {
                        noteApp.fetchhData()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            isSignedIn = false
                        } catch {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(8)
                            .padding([.horizontal, .bottom])
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationTitle("Notes")
            }
        } else {
            AuthView()
        }
    }
}


#Preview {
    ContentView()
}

