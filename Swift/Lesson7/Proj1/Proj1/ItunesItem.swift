import UIKit

struct ItunesItem: CustomStringConvertible{
	let artistName: String
	let releaseDate: String
	let name: String
	let artistUrl: String
	let artworkUrl100: UIImage
	let url: String
	
	var description: String{
		let s="""
		name: \(name)
		artistName: \(artistName)
		releaseDate: \(releaseDate)
		artistUrl: \(artistUrl)
		url: \(url)
		
		"""
		return s
	}
}
