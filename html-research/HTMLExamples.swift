//
//  HTMLExamples.swift
//  html-research
//
//  Created by Alexey Agapov on 10.08.2022.
//

import Foundation

func htmlExamples() -> [String] {
    [
        "Hello <b>world</b>. <a href=\"https://twitter.com\">TWITTAR</a>",
        "Hello <b>world</b> of the greatest man alive on the planet and forever. Check out our <a href=\"twitter.com\">TWITTAR</a> account",
        """
<h2>HTML Links</h2>
<p>HTML links are defined with the a tag:</p>

<a href="https://www.w3schools.com">This is a link</a>
""",
        """
<p><b>This paragraph is bold</b></p>
<p><i>This paragraph is italic</i></p>
<p><b><i>This paragraph is bolditalic</i></b></p>
<p><i><b>This paragraph is italicbold</b></i></p>
<p>This is<sub> subscript</sub> and <sup>superscript</sup></p>
""",
        "<p>This is a <em>terrible</em> idea.<br/>I must be daft.</p>"
    ]
}
