//
//  html_researchTests.swift
//  html-researchTests
//
//  Created by Alexey Agapov on 09.08.2022.
//

import XCTest
@testable import html_research

class html_researchTests: XCTestCase {

    func testPerformanceAtributika() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
        measure(options: options) {
            htmlExamples().forEach {
                $0.style(tags: Atributika.tagsStyles)
                    .attributedString
            }
        }
    }

    func testPerformanceAshton() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
        measure(options: options) {
            htmlExamples().forEach {
                ashton($0)
            }
        }
    }

    func testPerformanceRich() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
        measure(options: options) {
            htmlExamples().forEach {
                rich($0)
            }
        }
    }

    func testPerformanceSync() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
        measure(options: options) {
            htmlExamples().forEach {
                NSAttributedString(htmlString: $0)
            }
        }
    }

    func testPerformanceAsync() throws {
        let options = XCTMeasureOptions()
        options.iterationCount = 100
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
}
