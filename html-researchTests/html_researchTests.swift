//
//  html_researchTests.swift
//  html-researchTests
//
//  Created by Alexey Agapov on 09.08.2022.
//

import XCTest
@testable import html_research

class html_researchTests: XCTestCase {

    var options: XCTMeasureOptions!
    override func setUp() {
        super.setUp()
        options = XCTMeasureOptions()
        options.iterationCount = 1000
    }

    func testPerformanceAtributika() throws {
        measure(options: options) {
            htmlExamples().forEach {
                $0.style(tags: Atributika.tagsStyles)
                    .attributedString
            }
        }
    }

    func testPerformanceAshton() throws {
        measure(options: options) {
            htmlExamples().forEach {
                ashton($0)
            }
        }
    }

    func testPerformanceRich() throws {
        measure(options: options) {
            htmlExamples().forEach {
                rich($0)
            }
        }
    }

    func testPerformanceSync() throws {
        measure(options: options) {
            htmlExamples().forEach {
                NSAttributedString(htmlString: $0)
            }
        }
    }

    func testPerformanceAsync() throws {
        measure(options: options) {
            htmlExamples().forEach {
                let exp = expectation(description: "async method")
                NSAttributedString.loadFromHTML(string: $0) { _, _, _ in
                    exp.fulfill()
                }
                wait(for: [exp], timeout: 200)
            }
        }
    }

    func testPerformanceBonmot() throws {
        measure(options: options) {
            htmlExamples().forEach {
                bonmot($0)
            }
        }
    }
}
