//
//  ContentView.swift
//  klassenarbeits-text-editor
//
//  Created by David Polster on 25.04.23.
//

import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults.standard
    @State private var isPresentingConfirm: Bool = false
    @State private var editor = 0
    @State var textMain: String = "Viel Glück! (Text Feld) Dieses wird über den Teilen Knopf geteilt"
    @State var textPlan: String = "Glück Viel! (Schreibplan)"
    @State var textNote: String = "Glückliche Viele! (Notizen)"
    
    var body: some View {
        NavigationStack {
          Picker("What is your favorite color?", selection: $editor) {
              Text("1").tag(0)
              Text("2").tag(1)
              Text("3").tag(2)
          } .pickerStyle(.segmented)
                .frame(width: 300, height: 30, alignment: .centerLastTextBaseline)
            if editor == 0 {
                TextEditor(text: $textMain)
                    .padding()
                      .keyboardType(.alphabet)
                      .disableAutocorrection(true)
            } else if editor == 1 {
                TextEditor(text: $textPlan)
                    .padding()
                      .keyboardType(.alphabet)
                      .disableAutocorrection(true)
            } else if editor == 2 {
                TextEditor(text: $textNote)
                    .padding()
                      .keyboardType(.alphabet)
                      .disableAutocorrection(true)
            }
                Spacer()
                .navigationTitle("Klassenarbeit")
                        .toolbar {
                            ShareLink(item: textMain)

                            Button("Laden") {
                                textMain = defaults.object(forKey: "textMain") as! String
                                textPlan = defaults.object(forKey: "textPlan") as! String
                                textNote = defaults.object(forKey: "textNote") as! String
                            }
                            
                            Button("Speichern") {
                                defaults.set(textMain, forKey: "textMain")
                                defaults.set(textPlan, forKey: "textPlan")
                                defaults.set(textNote, forKey: "textNote")
                            }
                            
                            Button("Alles Löschen") {
                                isPresentingConfirm = true
                            }
                            .tint(.red)
                            .confirmationDialog("Sicher?",
                              isPresented: $isPresentingConfirm) {
                              Button("Ja alles löschen", role: .destructive) {
                                  textMain = "Viel Glück!  (Text Feld) Dieses wird über den Teilen Knopf geteilt"
                                  defaults.set("Viel Glück!  (Text Feld) Dieses wird über den Teilen Knopf geteilt", forKey: "textMain")
                                  textPlan = "Glück Viel! (Schreibplan)"
                                  defaults.set("Glück Viel! (Schreibplan)", forKey: "textPlan")
                                  textNote = "Glückliche Viele! (Notizen)"
                                  defaults.set("Glückliche Viele! (Notizen)", forKey: "textNote")
                                  isPresentingConfirm = false
                               }
                             }
                        }
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
