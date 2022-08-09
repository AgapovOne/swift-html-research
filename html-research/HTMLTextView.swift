//
//  HTMLTextView.swift
//  html-research
//
//  Created by Alexey Agapov on 09.08.2022.
//

import UIKit
import SwiftUI
import Atributika

final class HTMLTextView: UIView {

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

    var tagsStyles: [Style] {
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

    private func setText() {
        let now = Date.now

        textView.attributedText = text
            .style(tags: tagsStyles)
            .attributedString
        textView.textAlignment = .center

        let size = textView.systemLayoutSizeFitting(CGSize(width: self.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)

        let allText = textView.attributedText +
        "\n\(size)"
            .styleAll(.foregroundColor(.green))
            .attributedString
        + "\n\(now.distance(to: .now))".attributedString

        textView.attributedText = allText
    }
}

struct TextView: UIViewRepresentable {
    let text: String

    func makeUIView(context: Context) -> HTMLTextView {
        let v = HTMLTextView(frame: .zero)
        v.text = text
        return v
    }

    func updateUIView(_ uiView: HTMLTextView, context: Context) {
        uiView.text = text
    }
}
