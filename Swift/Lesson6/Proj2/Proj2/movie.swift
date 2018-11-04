import UIKit

struct Movie{
	let title: String
	let director: String
	let image: UIImage
}

struct MovieDataSource{
	func getMovies(from source: String, do callback: ([Movie]) -> Void) -> [Movie]{
		let movies = [
			Movie(title: "Incredibles 2", director: "Brad Bird", image:UIImage(named: "1")!),
			Movie(title: "Mile 22", director: "Peter Berg", image:UIImage(named: "2")!),
			Movie(title: "The Meg", director: "Jon Turteltaub", image:UIImage(named: "3")!),
			Movie(title: "The Spy Who Dumped Me", director: "Susanna Fogel", image:UIImage(named: "4")!),
			Movie(title: "Ant-Man and the Wasp", director: "Peyton Reed", image:UIImage(named: "5")!)
		]
		callback(movies)
		return movies
	}
}
