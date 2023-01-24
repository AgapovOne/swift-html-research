//
//  SnapshotTests.swift
//  html-researchTests
//
//  Created by Alex Agapov on 24.01.2023.
//

import XCTest
@testable import html_research
import SnapshotTesting

final class SnapshotTests: XCTestCase {

    func testBonmotSnapshots() throws {
//        isRecording = true
        htmlExamples().forEach {
            do {
                let input = $0
                let str = try bonmot(input)

                assertSnapshot(matching: str, as: .image)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }
}

extension Snapshotting where Value == NSAttributedString, Format == UIImage {
    public static var image: Snapshotting {
        Snapshotting<UIView, UIImage>.image.pullback { (attributedString: NSAttributedString) in
            let textView = UITextView()
            textView.attributedText = attributedString
            return textView
        }
    }
}
