//
//  HTMLAssign.swift
//  html-research
//
//  Created by Alexey Agapov on 10.08.2022.
//

import Foundation
import UIKit

let refTextView = UITextView()

func assign(
    _ string: NSAttributedString,
    to textView: UITextView,
    start: Date,
    width: CGFloat
) {
    refTextView.attributedText = string
    let size = refTextView.systemLayoutSizeFitting(
        CGSize(
            width: width,
            height: UIView.layoutFittingCompressedSize.height
        ),
        withHorizontalFittingPriority: .required,
        verticalFittingPriority: .fittingSizeLevel
    )

    let mutable = NSMutableAttributedString(attributedString: string)
    mutable.append(NSAttributedString(string: "\nsize:\(size), containerW: \(width)"))

    mutable.append(NSAttributedString(string: "\ntime: \(start.distance(to: .now))"))

    textView.attributedText = mutable
}
