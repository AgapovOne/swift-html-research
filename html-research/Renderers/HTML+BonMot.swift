//
//  HTML+BonMot.swift
//  html-research
//
//  Created by Alexey Agapov on 19.08.2022.
//

import UIKit
import BonMot

func bonmot(_ input: String) -> NSAttributedString {
    let normalStyle = StringStyle(.font(UIFont.systemFont(ofSize: 17)))
    let boldStyle = normalStyle.byAdding([.emphasis(.bold)])
    let italicStyle = normalStyle.byAdding([.emphasis(.italic)])

    let fishStyle = StringStyle(
        .xmlRules([
            .style("strong", boldStyle),
            .style("b", boldStyle),
            .style("i", italicStyle),
            .style("s", normalStyle.byAdding([.strikethrough(.single, nil)])),
            .style("sub", normalStyle.byAdding([.subscript(true)])),
            .style("sup", normalStyle.byAdding([.superscript(true)])),
            .exit(element: "br", insert: "\n"),
            .styleBlock("a", { wat in
                guard
                    let url = wat["href"].flatMap(URL.init(string:))
                else { return StringStyle() }
                return StringStyle(
                    .color(.brown),
                    .link(url)
                )
            })
        ])
    ).byAdding(stringStyle: normalStyle)

    return input.styled(with: fishStyle)
}
