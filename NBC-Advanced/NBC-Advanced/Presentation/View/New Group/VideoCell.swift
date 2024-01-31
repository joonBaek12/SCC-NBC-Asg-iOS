//
//  VideoCell.swift
//  NBC-Advanced
//
//  Created by Joon Baek on 2024/01/26.
//

import UIKit

import SnapKit

// MARK: - VideoCell

final class VideoCell: UITableViewCell {
    
    static let identifier = "VideoCell"
    
    let thumbnailView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension VideoCell {
    private func setLayout() {
        [thumbnailView, titleLabel].forEach { contentView.addSubview($0) }
        
        thumbnailView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(thumbnailView.snp.height).multipliedBy(16.0/9.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setThumbnail(imageURL: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.thumbnailView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.thumbnailView.tintColor = .lightGray
                    self?.thumbnailView.image = UIImage(systemName: "play.rectangle.fill")
                }
            }
        }
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
