//
//  CollectionView.swift
//  html-research
//
//  Created by Alexey Agapov on 16.08.2022.
//

import UIKit

final class CollectionView: UICollectionViewController {

    let items: [String] = htmlExamples() + markdownExamples()
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        let textView = HTMLTextView {
            down($0, styler: DefaultDownStyler())
        }
        cell.addSubview(textView)
        let item = items[indexPath.row]
        textView.text = item
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32

        return CGSize(width: width, height: 100)
    }
}
