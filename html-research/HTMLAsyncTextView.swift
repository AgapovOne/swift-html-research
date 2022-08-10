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

    typealias HTMLLoader = (String, @escaping (NSAttributedString) -> Void) -> Void
    let loader: HTMLLoader

    let textView = UITextView()

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
        loader(text) { string in
            assign(
                string,
                to: self.textView,
                start: now,
                width: self.frame.width
            )
        }
    }
}

struct AsyncTextView: UIViewRepresentable {
    let text: String
    let loader: HTMLAsyncTextView.HTMLLoader

    func makeUIView(context: Context) -> HTMLAsyncTextView {
        let v = HTMLAsyncTextView(loader: loader)
        v.text = text
        return v
    }

    func updateUIView(_ uiView: HTMLAsyncTextView, context: Context) {
        uiView.text = text
    }
}
