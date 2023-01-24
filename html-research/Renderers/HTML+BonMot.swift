//
//  HTML+BonMot.swift
//  html-research
//
//  Created by Alexey Agapov on 19.08.2022.
//

import UIKit
import BonMot

func bonmot(_ input: String) throws -> NSAttributedString {
    let normalStyle = StringStyle(.font(.italicSystemFont(ofSize: 8)))
    let boldStyle = normalStyle
        .byAdding([.emphasis(.bold)])
    let italicStyle = normalStyle
        .byAdding([.emphasis(.italic)])
    let strikethroughStyle = normalStyle
        .byAdding([.strikethrough(.single, nil)])

    let xmlRules: [XMLStyleRule] = [
        .style("strong", boldStyle),
        .style("b", boldStyle),
        .style("i", italicStyle),
        .style("s", strikethroughStyle),
        .enter(element: "br", insert: "\n"),

        .styleBlock("a", { wat in
            guard
                let url = wat["href"]
                    .flatMap(URL.init(string:))
            else { return normalStyle }
            return StringStyle(.font(.boldSystemFont(ofSize: 10)))
                .byAdding([.link(url)])
        })
    ]

    return try NSAttributedString.composed(
        ofXML: input.escapeWithUnicodeEntities(),
        baseStyle: normalStyle,
        rules: xmlRules
    )
}

private extension String {

    private static let escapeAmpRegExp = try! NSRegularExpression(
        pattern: "&(?!(#[0-9]{2,4}|[A-z]{2,6});)",
        options: NSRegularExpression.Options(rawValue: 0)
    )

    func escapeWithUnicodeEntities() -> String {
        String.escapeAmpRegExp.stringByReplacingMatches(
            in: self,
            options: NSRegularExpression.MatchingOptions(rawValue: 0),
            range: NSRange(location: 0, length: self.count),
            withTemplate: "&amp;"
        )
    }

}
