//
//  MovieListViewController.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import UIKit
import BestMoviesAPI
import Combine

final class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var errorLabel: UILabel!
    
    var viewModel: MovieListViewModelProtocol! 
    
    private var movieList: [MoviePresentation] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bind(to: viewModel)
        
        viewModel.load()
    }
   
    func bind(to viewModel: MovieListViewModelProtocol) {
        
        viewModel.loadingPublisher
            .sink { [weak self] isLoading in
                self?.activityIndicator.isHidden = !isLoading
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &subscriptions)
        
        viewModel.hasBestMoviesDataPublisher
            .map { !$0 }
            .assign(to: \.isHidden, on: tableView)
            .store(in: &subscriptions)
        
        viewModel.hasErrorPublisher
            .map { !$0 }
            .assign(to: \.isHidden, on: errorLabel)
            .store(in: &subscriptions)
        
        viewModel.bestMoviesStatePublisher
            .sink { [weak self] apiState in
                switch apiState {
                        
                    case .data(let presentationList):
                        self?.movieList = presentationList
                        self?.tableView.reloadData()
                        
                    case .error(let error):
                        switch error {
                            case .failedRequest:
                                self?.errorLabel.text = "Request failed"
                            case .noInternetConnection:
                                self?.errorLabel.text = "There is no internet connection"
                            case .invalidResponse:
                                self?.errorLabel.text = "Response doesn't match with model data"
                        }
                        
                    case .loading:
                        break
                }
            }
            .store(in: &subscriptions)
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath)
        let movie = movieList[indexPath.row]
        
        if #available(iOS 14, *) {
            var movieContent = cell.defaultContentConfiguration()
            movieContent.text = movie.title
            movieContent.secondaryText = movie.detail
            cell.contentConfiguration = movieContent
        } else {
            cell.textLabel?.text = movie.title
            cell.detailTextLabel?.text = movie.detail
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetail(with: viewModel.selectMovie(at: indexPath.row))
    }
    
    private func showDetail(with detailViewModel: MovieDetailViewModel) {
        let viewController = MovieDetailBuilder.make(with: detailViewModel)
        
        self.show(viewController, sender: nil)
    }
}
