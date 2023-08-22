//
//  MovieDetailViewController.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    @IBOutlet weak var stackName: UIStackView!
    @IBOutlet weak var stackPrice: UIStackView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
    @IBOutlet weak var movieSummaryLabel: UILabel!

    var viewModel: MovieDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.load()
    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func showDetail(_ presentation: MovieDetailPresentation) {
        movieTitleLabel.text = presentation.title
        moviePriceLabel.text = presentation.price
        movieSummaryLabel.text = presentation.summary + presentation.summary + presentation.summary
        app.mediaService.downloadImage(from: presentation.imageUrl ?? "") {[weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let image):
                    self.movieImage.image = image
                case .failure(let error):
                    print("\(error.localizedDescription)")
            }
        }
    }
}

extension MovieDetailViewController {
    func setupView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        viewContainer.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        viewContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        
        stackName.translatesAutoresizingMaskIntoConstraints = false
        stackName.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10).isActive = true
        stackName.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        stackName.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10).isActive = true
        stackName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackPrice.translatesAutoresizingMaskIntoConstraints = false
        stackPrice.topAnchor.constraint(equalTo: stackName.bottomAnchor, constant: 10).isActive = true
        stackPrice.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        stackPrice.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10).isActive = true
        stackPrice.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: stackPrice.bottomAnchor, constant: 10).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        movieImage.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        
        
        movieSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        movieSummaryLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10).isActive = true
        movieSummaryLabel.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: 10).isActive = true
        movieSummaryLabel.rightAnchor.constraint(equalTo: viewContainer.rightAnchor, constant: -10).isActive = true
        movieSummaryLabel.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -20).isActive = true
        movieSummaryLabel.numberOfLines = 0
        movieSummaryLabel.lineBreakMode = .byWordWrapping
    }
}
