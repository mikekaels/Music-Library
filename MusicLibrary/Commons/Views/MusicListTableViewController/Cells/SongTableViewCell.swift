//
//  SongTableViewCell.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import UIKit
import SnapKit

class SongTableViewCell: UITableViewCell {
    
    public var addButton: UIButton = UIButton()
        .configure { v in
            v.setTitle("Add to fav", for: .normal)
            v.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            v.setTitleColor(Colors.font, for: .normal)
            v.addTarget(self, action: #selector(tapped), for: .touchUpInside)
            v.layer.borderWidth = 2
            v.layer.borderColor = Colors.font.cgColor
            v.layer.masksToBounds = true
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: nil)
        setupUI()
    }
    
    @objc func tapped() {
        print("Add to favorite")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SongTableViewCell {
    func setupUI() {
        contentView.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
