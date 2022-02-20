//
//  Extension + UITableView.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 21/02/22.
//

import UIKit

extension UITableView {
    
    public func scrollToTop(animated: Bool = false) {
        if numberOfRows(inSection: 0) > 0 {
            scrollToRow(
                at: .init(row: 0, section: 0),
                at: .top,
                animated: animated
            )
        }
    }
    
}

