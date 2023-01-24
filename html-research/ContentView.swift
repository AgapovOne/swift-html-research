//
//  ContentView.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import SwiftUI

struct ContentView: View {
    enum Format: String, CaseIterable, Identifiable {
        case html, markdown
        var id: Self { self }
    }
    enum HTMLRenderer: String, CaseIterable, Identifiable {
        case atributika, sync, async, bonmot, ashton
        var id: Self { self }
    }
    enum MarkdownRenderer: String, CaseIterable, Identifiable {
        case downCustom, downDefault, native15
        var id: Self { self }
    }

    @State private var format: Format = .html
    @State private var selectedHTMLRenderer: HTMLRenderer = .bonmot
    @State private var selectedMarkdownRenderer: MarkdownRenderer = .downCustom

    var body: some View {
        VStack {
            HStack {
                Picker(
                    "Format",
                    selection: $format
                ) {
                    ForEach(Format.allCases) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)


                Picker(
                    "HTML Renderer",
                    selection: $selectedHTMLRenderer
                ) {
                    ForEach(HTMLRenderer.allCases) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)

                Picker(
                    "Markdown Renderer",
                    selection: $selectedMarkdownRenderer
                ) {
                    ForEach(MarkdownRenderer.allCases) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            VStack {
                switch format {
                    case .html:
                        ForEach(htmlExamples(), id: \.string) { html in
                            rendered(html: html)
                        }
                    case .markdown:
                        ForEach(markdownExamples(), id: \.string) { markdown in
                            rendered(markdown: markdown)
                        }
                }
            }
        }
    }

    @ViewBuilder
    private func rendered(html: String) -> some View {
        switch selectedHTMLRenderer {
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
                        completion(string ?? NSAttributedString())
                    }
                }
            case .atributika:
                TextView(text: html) {
                    $0
                        .style(tags: Atributika.tagsStyles)
                        .attributedString
                }

            case .ashton:
                TextView(text: html) {
                    ashton($0)
                }
            case .bonmot:
                TextView(text: html) {
                    try! bonmot($0)
                }
        }
    }

    @ViewBuilder
    private func rendered(markdown: String) -> some View {
        switch selectedMarkdownRenderer {
            case .downCustom:
                TextView(text: markdown) {
                    down($0, styler: MyStyler())
                }
            case .downDefault:
                TextView(text: markdown) {
                    down($0, styler: DefaultDownStyler())
                }
            case .native15:
                TextView(text: markdown) {
                    markdown15($0)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
