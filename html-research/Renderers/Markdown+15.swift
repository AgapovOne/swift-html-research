//
//  Markdown+15.swift
//  html-research
//
//  Created by Alexey Agapov on 17.08.2022.
//

import Foundation

func markdown15(_ input: String) -> NSAttributedString {
    let string = try! AttributedString(
        markdown: input,
        options: .init(
            allowsExtendedAttributes: true,
            interpretedSyntax: .full
        )
    )
    let container = AttributeContainer()
    return NSAttributedString(string)
}
