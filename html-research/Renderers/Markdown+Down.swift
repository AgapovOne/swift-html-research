//
//  Markdown+Down.swift
//  html-research
//
//  Created by Alexey Agapov on 16.08.2022.
//

import UIKit
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

private extension NSMutableAttributedString {
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

public class DefaultDownStyler: DownStyler {}
