//
//  FactListViewCell.swift
//  ProofOfConcept
//
//  Created by administrator on 09/11/20.
//  Copyright © 2020 administrator. All rights reserved.
//

import UIKit
import Kingfisher

class FactListViewCell: UITableViewCell {

    let factImageView = UIImageView()
    let titleLabel = UILabel()
    let detailLabel = UILabel()
    var row : FactRow? {
        didSet {
            
            guard let row = row else {
                return
            }
            
          titleLabel.text = "\(row.title ?? "")"
          detailLabel.text = row.description
          if let image = row.imageHref {
            let url = URL(string: image)!
            let imageView = ImageResource(downloadURL: url, cacheKey: "\(url)-imageview")
            factImageView.kf.setImage(with: imageView,placeholder: UIImage(named: "imagePlaceHolder.png"))
          }
          else {
            factImageView.image = nil
          }
    }
  }

    // MARK: Initalizers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    let marginGuide = contentView.layoutMarginsGuide
        // configure imageview
    contentView.addSubview(factImageView)
    factImageView.translatesAutoresizingMaskIntoConstraints = false
    factImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    factImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    factImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        // configure titleLabel
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    titleLabel.topAnchor.constraint(equalTo: factImageView.bottomAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    titleLabel.numberOfLines = 0
        // configure authorLabel
    contentView.addSubview(detailLabel)
    detailLabel.translatesAutoresizingMaskIntoConstraints = false
    detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    detailLabel.numberOfLines = 0
    detailLabel.textColor = UIColor.lightGray
  }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
