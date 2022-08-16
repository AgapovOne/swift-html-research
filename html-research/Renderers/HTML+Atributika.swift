//
//  HTML+Atributika.swift
//  html-research
//
//  Created by Alexey Agapov on 16.08.2022.
//

import Foundation
import Atributika

enum Atributika {
    static var tagsStyles: [Style] {
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
}
