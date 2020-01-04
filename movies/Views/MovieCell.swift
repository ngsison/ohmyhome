//
//  MovieCell.swift
//  movies
//
//  Created by Nathaniel Brion Sison on 04/01/2020.
//  Copyright © 2020 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
  
  // MARK: - Public Props
  
  public var movie: Movie = Movie()
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var releaseDateLabel: UILabel!
  @IBOutlet private weak var ratingLabel: UILabel!
  @IBOutlet private weak var overviewLabel: UILabel!
  
  // MARK: - Lifecycle Events
  
  override class func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.resetValues()
  }
  
  // MARK: - Public Methods
  
  public func configure(_ movie: Movie) {
    if let posterImageUrl = URL(string: "\(Constants.POSTER_IMAGE_BASE_URL)\(movie.posterPath)") {
      self.posterImageView.kf.setImage(with: posterImageUrl)
    }
    
    self.titleLabel.text = movie.title
    self.releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
    self.ratingLabel.text = "Rating: \(movie.voteAverage)"
    self.overviewLabel.text = movie.overview
  }
  
  // MARK: - Private Methods
  
  /**
   Reset the cell to its default empty  state.
   */
  
  private func resetValues() {
    self.posterImageView.image = nil
    self.titleLabel.text = ""
    self.releaseDateLabel.text = ""
    self.ratingLabel.text = ""
    self.overviewLabel.text = ""
  }
}
