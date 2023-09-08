//
//  BestMoviesMVVMTests.swift
//  BestMoviesMVVMTests
//
//  Created by Vedat Ozlu on 20.08.2023.
//

/*import XCTest
@testable import BestMoviesAPI
@testable import BestMoviesMVVM

final class BestMoviesMVVMTests: XCTestCase {
    
    private var view: MockView!
    private var viewModel: MovieListViewModel!
    private var service: MockService!
    
    override func setUpWithError() throws {
        service = MockService()
        viewModel = MovieListViewModel(service: service)
        view = MockView()
        viewModel.delegate = view
    }

    func testLoad() throws {
        // Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        service.movies = [movie1, movie2]
        
        // When:
        viewModel.load()
        
        // Then:
        XCTAssertEqual(view.outputs.count, 4)
        
        switch try view.outputs.element(at: 0) {
            case .updateTitle(_):
                break
            default:
                XCTFail("First output should be `updateTitle`")
        }
        
        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 2), .setLoading(false))
        
//        let expectedMovies = [movie1, movie2].map { MoviePresentation(movie: $0) }
//        XCTAssertEqual(try view.outputs.element(at: 3), .showMovieList(expectedMovies))
    }
    
    func testNavigation() throws {
        // Given:
        let movie1 = try ResourceLoader.loadMovie(resource: .movie1)
        let movie2 = try ResourceLoader.loadMovie(resource: .movie2)
        service.movies = [movie1, movie2]
        viewModel.load()
        view.reset()
        
        // When:
        viewModel.selectMovie(at: 0)
        
        // Then:
        XCTAssertTrue(view.detailRouteCalled)
    }

}

private final class MockService: BestMoviesServiceProtocol {
    
    var movies: [Movie] = []
    
    func fetchBestMovies(completion: @escaping (BestMoviesAPI.Result<BestMoviesAPI.BestMoviesResponse>) -> Void) {
        completion(.success(BestMoviesResponse(entry: movies)))
    }
}

private class MockView: MovieListViewModelDelegate {
    
    var outputs: [MovieListViewModelOutput] = []
    var detailRouteCalled: Bool = false
    
    func reset() {
        outputs.removeAll()
        detailRouteCalled = false
    }
    
    func handleViewModelOutput(_ output: BestMoviesMVVM.MovieListViewModelOutput) {
        outputs.append(output)
    }
    
    func navigate(to route: BestMoviesMVVM.MovieListViewRoute) {
        switch route {
            case .detail:
                detailRouteCalled = true
        }
    }
}

extension Array { //for preventing crash during test
    
    struct IndexOutOfBoundsError: Error { }
    
    func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
}
*/
