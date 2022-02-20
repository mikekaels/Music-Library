//
//  SongTableViewCell.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import UIKit
import SnapKit

protocol SongCellDelegate {
    func removeFromFavorite(id: NSNumber)
    func addToFavorites(id: NSNumber, songTitle: String, singer: String)
}

enum State {
    case saved
    case add
}

class SongTableViewCell: UITableViewCell {
    
    var delegate: SongCellDelegate?
    var state: State? {
        didSet {
            if state == .add { btnAdd.tintColor = Colors.gray10 }
            else if state == .saved { btnAdd.tintColor = Colors.accent}
//            if state == .add { btnAdd.setTitle("Add to fav", for: .normal) }
//            else if state == .saved { btnAdd.setTitle("Remove", for: .normal) }
        }
    }
    var data: SongsModel?
    var id: NSNumber?
    
    let svDescription: UIStackView = UIStackView()
        .configure { v in
            v.axis = .vertical
            v.distribution = .equalSpacing
            v.backgroundColor = .clear
            v.spacing = 8
        }
    
    let lblSongTitle: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 16)
            v.textColor = Colors.title
        }
    
    let lblSinger: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 13)
            v.textColor = Colors.subTitle
        }
    
    
    lazy var btnAdd: UIButton = UIButton()
        .configure { v in
//            v.setTitle("Add to fav", for: .normal)
//            v.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
//            v.setTitleColor(Colors.title, for: .normal)
            v.addTarget(self, action: #selector(tapped), for: .touchUpInside)
//            v.layer.borderWidth = 2
//            v.layer.borderColor = Colors.title.cgColor
//            v.layer.masksToBounds = true
            v.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: nil)
        setupUI()
    }
    
    @objc func tapped() {
        if let state = self.state {
            switch state {
            case .add:
                delegate?.addToFavorites(id: self.id!, songTitle: self.lblSongTitle.text!, singer: self.lblSinger.text!)
                self.state = .saved
            case .saved:
                delegate?.removeFromFavorite(id: self.id!)
                self.state = .add
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SongTableViewCell {
    func setupUI() {
        self.contentView.backgroundColor = Colors.background
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
            make.width.equalTo(30)
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(10)
        }
    }
}
