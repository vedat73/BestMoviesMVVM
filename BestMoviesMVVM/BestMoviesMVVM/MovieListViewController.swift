//
//  MovieListViewController.swift
//  BestMoviesMVVM
//
//  Created by Vedat Ozlu on 19.08.2023.
//

import UIKit
import BestMoviesAPI

final class MovieListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    private var movieList: [MoviePresentation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func handleViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
            case .updateTitle(let title):
                self.title = title
            case .setLoading(let isLoading):
                print(isLoading ? "isloading true " : "isloading false")
            case .showMovieList(let movieList):
                self.movieList = movieList
                tableView.reloadData()
        }
    }
    
    func navigate(to route: MovieListViewRoute) {
        switch route {
            case .detail(let viewModel):
                let viewController = MovieDetailBuilder.make(with: viewModel)
                show(viewController, sender: nil)
        }
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
        viewModel.selectMovie(at: indexPath.row)
    }
}
