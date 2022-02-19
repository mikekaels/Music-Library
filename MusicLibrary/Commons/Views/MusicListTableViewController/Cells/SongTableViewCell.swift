//
//  SongTableViewCell.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import UIKit
import SnapKit

class SongTableViewCell: UITableViewCell {
    
    let svDescription: UIStackView = UIStackView()
        .configure { v in
            v.axis = .vertical
            v.distribution = .equalSpacing
        }
    
    let lblSongTitle: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 17)
            v.textColor = Colors.font
            v.text = "hahaha"
        }
    
    let lblSinger: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 15)
            v.textColor = Colors.font
            v.text = "hahaha"
        }
    
    
    lazy var btnAdd: UIButton = UIButton()
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
        contentView.addSubview(btnAdd)
        contentView.addSubview(svDescription.configure(completion: { v in
            [lblSongTitle, lblSinger].forEach { v.addArrangedSubview($0)}
        }))
        
        lblSongTitle.snp.makeConstraints { make in
            make.leading.trailing.equalTo(svDescription)
        }
        
        svDescription.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(btnAdd.snp_leadingMargin).offset(-30)
        }
        
        btnAdd.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
