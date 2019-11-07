//
//  PostItemViewCell.swift
//  Collabrate
//
//  Created by Guowei Mo on 21/10/2019.
//  Copyright © 2019 Guowei Mo. All rights reserved.
//

import UIKit

class PostItemViewCell: UITableViewCell {
  
  private let titleLabel = UILabel()
  private let postImageView = UIImageView()
  private let descriptionLabel = UILabel()
  private let locationLabel = UILabel()
  private let viewCountLabel = UILabel()
  private let applyCountLabel = UILabel()
  private let saveCountLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    createView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    createView()
  }
  
  private func createView() {
    titleLabel.numberOfLines = 2
    contentView.addAutoLayoutSubview(titleLabel, constraining: [
      .equal(\.leadingAnchor),
      .equal(\.trailingAnchor),
      .equal(\.topAnchor),
    ])
    
    descriptionLabel.numberOfLines = 3
    let detailView = UIView()
    detailView.addAutoLayoutSubview(descriptionLabel, constraining: [
      .equal(\.leadingAnchor),
      .equal(\.topAnchor),
      .equal(\.bottomAnchor)
    ])
    detailView.addAutoLayoutSubview(postImageView, constraining: [
      .equal(\.topAnchor),
      .equal(\.bottomAnchor),
      .equal(\.trailingAnchor),
    ])
    postImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    postImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    postImageView.contentMode = .scaleAspectFit
    descriptionLabel.heightAnchor.constraint(equalTo: postImageView.heightAnchor).isActive = true
    descriptionLabel.constraintAgainst(postImageView, with: [
      .equal(\.trailingAnchor, with: \.leadingAnchor, constant: 12)
    ])
    contentView.addAutoLayoutSubview(detailView, constraining: [
      .equal(\.leadingAnchor),
      .equal(\.trailingAnchor),
    ])
    detailView.constraintAgainst(titleLabel, with: [
      .equal(\.bottomAnchor, with: \.topAnchor, constant: 8)
    ])
    
    contentView.addAutoLayoutSubview(locationLabel, constraining: [
      .equal(\.leadingAnchor),
      .equal(\.trailingAnchor),
      .equal(\.bottomAnchor),
    ])
    locationLabel.constraintAgainst(detailView, with: [
      .equal(\.bottomAnchor, with: \.topAnchor, constant: 8)
    ])
  }
  
  func update() {
    titleLabel.text = "Model wanted around London"
    descriptionLabel.text = "Reach professional talent and fresh faces by placing a free casting call. See applicants' experience, photos, videos, audio and more. Easily sort applications, make notes on them and cast the perfect talent. Contact and book talent direct."
    postImageView.image = nil
    locationLabel.text = "London, UK"
  }
}
