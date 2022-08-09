//
//  HTMLAsyncTextView.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import UIKit
import SwiftUI
import WebKit

final class HTMLAsyncTextView: UIView {

    let textView = UITextView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(textView)
        textView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setText()
    }

    var text: String = "" {
        didSet {
            setText()
        }
    }

    private func setText() {
        let now = Date.now
        NSAttributedString.loadFromHTML(
            string: text,
            completionHandler: { string, keys, error in
                self.textView.attributedText = string
                let size = self.textView.systemLayoutSizeFitting(
                    CGSize(
                        width: self.frame.width,
                        height: UIView.layoutFittingCompressedSize.height
                    ),
                    withHorizontalFittingPriority: .required,
                    verticalFittingPriority: .fittingSizeLevel
                )

                let mutable = NSMutableAttributedString(attributedString: self.textView.attributedText)
                mutable.append(NSAttributedString(string: "\n\(size)"))

                mutable.append(NSAttributedString(string: "\n\(now.distance(to: .now))"))

                self.textView.attributedText = mutable

            }
        )
    }
}

struct AsyncTextView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> HTMLAsyncTextView {
        let v = HTMLAsyncTextView(frame: .zero)
        v.text = text
        return v
    }

    func updateUIView(_ uiView: HTMLAsyncTextView, context: Context) {
        uiView.text = text
    }
}
