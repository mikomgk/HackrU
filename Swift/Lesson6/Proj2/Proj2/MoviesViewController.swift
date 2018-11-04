import UIKit

class MoviesViewController: UIViewController {
	
	lazy var movies: [Movie] = {
		var x = MovieDataSource().getMovies(from: ""){_ in return}
		return x
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension MoviesViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return section == 0 ? movies.count : 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		let section = indexPath.section
		let movie = movies[row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
		cell.title?.text = movie.title
		cell.director?.text = movie.director
		cell.movieImage?.image = section == 0 ? movie.image : movies[1].image
		return cell
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
}

extension MoviesViewController: UITableViewDelegate{
	
}

