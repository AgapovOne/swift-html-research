//
//  ContentView.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import SwiftUI

struct ContentView: View {
    enum Renderer: String, CaseIterable, Identifiable {
        case atributika, sync, async
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
            VStack {
                ForEach(htmlExamples(), id: \.string) { html in
                    switch selectedRenderer {
                        case .sync:
                            TextView(text: html) {
                                NSAttributedString(htmlString: $0)!
                            }
                        case .async:
                            AsyncTextView(
                                text: html
                            ) { string, completion in
                                NSAttributedString.loadFromHTML(
                                    string: string
                                ) { string, keys, error in
                                    completion(string!)
                                }
                            }
                        case .atributika:
                            TextView(text: html) {
                                $0
                                    .style(tags: Atributika.tagsStyles)
                                    .attributedString
                            }
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

// MARK: - Sync
public extension NSAttributedString {

    convenience init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8, allowLossyConversion: true) else {
            return nil
        }

        do {
            try self.init(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }
}


// MARK: - Atributika
import Atributika

enum Atributika {
    static var tagsStyles: [Style] {
        [
            Style("b")
                .font(.boldSystemFont(ofSize: 20))
                .foregroundColor(.red),
            Style("a")
                .font(.monospacedSystemFont(ofSize: 24, weight: .heavy))
                .foregroundColor(.brown),
            Style("sub")
                .baselineOffset(-10),
            Style("sup")
                .baselineOffset(10)
        ]
    }
}
