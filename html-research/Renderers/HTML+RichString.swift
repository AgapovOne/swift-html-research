//
//  HTML+RichString.swift
//  html-research
//
//  Created by Alexey Agapov on 17.08.2022.
//

import Foundation
import SwiftRichString
import UIKit

func rich(_ input: String) -> NSAttributedString {
    input.set(style: StyleXML(base: Style { $0.font = UIFont.systemFont(ofSize: 11) }, [:]))
}
