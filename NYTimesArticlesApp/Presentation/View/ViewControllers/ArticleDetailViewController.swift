//
//  DetailsViewController.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 27/08/2024.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    var viewModel: ArticleDetailsViewModelProtocol!
    var coordinator: DetailsCoordinatorProtocol?
    
    // Required dependencies initializer
    init?(coder: NSCoder, viewModel: ArticleDetailsViewModelProtocol, coordinator: DetailsCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must use init(coder:viewModel:coordinator:) instead")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // View setup
    private func setupUI() {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.publishedDate
        sourceLabel.text = viewModel.type
        if let coverPicUrl = viewModel.coverPic {
            coverImageView.setImage(with: coverPicUrl)
        } else {
            coverImageView.image = UIImage(systemName: "photo")
        }
    }
}
