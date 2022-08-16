//
//  Markdown.swift
//  html-research
//
//  Created by Alexey Agapov on 15.08.2022.
//

import Foundation

func markdownExamples() -> [String] {
    [
        "Hello **world**. [TWITTAR](https://twitter.com)",
        "Hello **world** of the greatest man alive on the planet and forever. Check out our [TWITTAR](https://twitter.com) account",
        """
## HTML Links
HTML links are defined with the a tag:

[This is a link](https://www.w3schools.com)
""",
        """
**This text is bold**
*This text is italic*
This is ~subscript~ and ^superscript^
""",
        "This is a ~~terrible~~ idea.<br/>I must be daft."
    ]
}
