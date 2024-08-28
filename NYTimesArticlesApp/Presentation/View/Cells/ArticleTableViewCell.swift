//
//  ArticleTableViewCell.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // -Outlets
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        //Reset
//        thumbnailImageView.image = UIImage(systemName: "bgImage")
//        titleLabel.text = nil
//        authorLabel.text = nil
//        dateLabel.text = nil
//    }
//    
    // Configuration
    func configure(with article: DomainArticle) {
      
        authorLabel.text = article.author
        dateLabel.text = article.formattedDate
        titleLabel.text = article.title
        //Load and set the image using the image cahe
        if let imageUrl = article.thumbnail {
            thumbnailImageView.setImage(with: imageUrl)
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
    }
 
    private func setupViews() {
        
        //Configure
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
    }
}
