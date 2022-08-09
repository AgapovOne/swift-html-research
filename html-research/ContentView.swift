//
//  ContentView.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import SwiftUI

struct ContentView: View {
    enum Renderer: String, CaseIterable, Identifiable {
        case async, atributika
        var id: Self { self }
    }

    @State private var selectedRenderer: Renderer = .async

    var body: some View {
        VStack {
            Picker(
                "Renderer",
                selection: $selectedRenderer
            ) {
                ForEach(Renderer.allCases) {
                    Text($0.rawValue)
                }
            }
                .pickerStyle(.menu)
//            ScrollView {
                ForEach(htmlExamples(), id: \.string) { html in
                    switch selectedRenderer {
                        case .async:
                            AsyncTextView(text: html)
                        case .atributika:
                            TextView(text: html)
                    }
                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
