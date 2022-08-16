//
//  HTML+Sync.swift
//  html-research
//
//  Created by Alexey Agapov on 16.08.2022.
//

import Foundation

public extension NSAttributedString {

    convenience init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8, allowLossyConversion: true) else {
            return nil
        }

        do {
            try self.init(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }
}
