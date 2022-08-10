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

    typealias HTMLLoader = (String) -> NSAttributedString
    let loader: HTMLLoader

    let textView = UITextView()
    var heightConstraint: NSLayoutConstraint!

    init(loader: @escaping HTMLLoader) {
        self.loader = loader
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
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

        assign(
            loader(text),
            to: textView,
            start: now,
            width: frame.width
        )
        
    }
}

struct TextView: UIViewRepresentable {
    let text: String
    let loader: HTMLTextView.HTMLLoader

    func makeUIView(context: Context) -> HTMLTextView {
        let v = HTMLTextView(loader: loader)
        v.text = text
        return v
    }

    func updateUIView(_ uiView: HTMLTextView, context: Context) {
        uiView.text = text
    }
}
