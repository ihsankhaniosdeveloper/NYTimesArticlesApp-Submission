//
//  ArticlesListView.swift
//  NYTimesArticlesApp
//
//  Created by Ihsan Ullah on 26/08/2024.
//

import Foundation
import UIKit

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell: ArticleTableViewCell = tableView.dequeueReusableCell(ofType: ArticleTableViewCell.self, for: indexPath) else {
                return UITableViewCell()
        }
        if let article = viewModel.getArticle(index: indexPath.row) {
            cell.configure(with: article)
        }
        cell.accessibilityIdentifier = "cell_\(indexPath.row)"

        return cell
     }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            // Assuming you have an array of articles in your ViewModel or Controller
        guard let selectedArticle = viewModel.getArticle(index: indexPath.row) else {return}
        self.coordinator?.showArticleDetails(for: selectedArticle)
        }
}

