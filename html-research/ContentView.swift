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
        case atributika, sync, async
        var id: Self { self }
    }
    enum MarkdownRenderer: String, CaseIterable, Identifiable {
        case downCustom, downDefault, native15
        var id: Self { self }
    }

    @State private var format: Format = .html
    @State private var selectedHTMLRenderer: HTMLRenderer = .async
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

    @ViewBuilder
    private func rendered(markdown: String) -> some View {
        switch selectedMarkdownRenderer {
            case .downCustom:
                TextView(text: markdown) {
                    down($0, styler: MyStyler())
                }
            case .downDefault:
                TextView(text: markdown) {
                    down($0, styler: DownStyler(configuration: .init()))
                }
            case .native15:
                TextView(text: markdown) {
                    NSAttributedString(try! AttributedString(
                        markdown: $0,
                        options: .init(
                            allowsExtendedAttributes: true,
                            interpretedSyntax: .full
                        )
                    ))
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

// MARK: - Down
import Down

public class MyStyler: Styler {
    public func style(document str: NSMutableAttributedString) {}

    public func style(listItemPrefix str: NSMutableAttributedString) {}

    public func style(htmlBlock str: NSMutableAttributedString) {

    }

    public func style(customBlock str: NSMutableAttributedString) {
        str.addAttributes([.foregroundColor: UIColor.red])
    }

    public func style(paragraph str: NSMutableAttributedString) {

    }

    public func style(thematicBreak str: NSMutableAttributedString) {

    }

    public func style(text str: NSMutableAttributedString) {
        str.addAttributes([
            .font: UIFont.preferredFont(forTextStyle: .footnote),
        ])
    }

    public func style(softBreak str: NSMutableAttributedString) {

    }

    public func style(lineBreak str: NSMutableAttributedString) {

    }

    public func style(code str: NSMutableAttributedString) {

    }

    public func style(htmlInline str: NSMutableAttributedString) {

    }

    public func style(customInline str: NSMutableAttributedString) {

    }

    public func style(emphasis str: NSMutableAttributedString) {

    }

    public func style(strong str: NSMutableAttributedString) {
        str.addAttributes([.font: UIFont.preferredFont(forTextStyle: .body)])
    }

    public func style(blockQuote str: NSMutableAttributedString, nestDepth: Int) {

    }

    public func style(list str: NSMutableAttributedString, nestDepth: Int) {

    }

    public func style(item str: NSMutableAttributedString, prefixLength: Int) {

    }

    public func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {

    }

    public func style(heading str: NSMutableAttributedString, level: Int) {

    }

    public func style(link str: NSMutableAttributedString, title: String?, url: String?) {

    }

    public func style(image str: NSMutableAttributedString, title: String?, url: String?) {

    }
}

extension NSMutableAttributedString {
    func setAttributes(_ attrs: [NSAttributedString.Key: Any]) {
        setAttributes(attrs, range: NSRange(location: 0, length: length))
    }

    func addAttributes(_ attrs: [NSAttributedString.Key: Any]) {
        addAttributes(attrs, range: NSRange(location: 0, length: length))
    }
}

func down(_ text: String, styler: Styler) -> NSAttributedString {
    try! Down(markdownString: text)
        .toAttributedString(styler: styler)
}
