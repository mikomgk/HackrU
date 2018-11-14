import UIKit

struct RssResult: Codable{
	var feed: Feed
}

struct Feed: Codable{
	var results: [ItunesItem]
}

struct ItunesItem: Codable{
	let artistName: String
	let id: String
	let releaseDate: String
	let name: String
	let kind: String
	let copyright: String
	let artistId: String
	let artistUrl: String
	let artworkUrl100: String
	let genres: [genere]
	let url: String
}

struct genere: Codable{
	let genreId: String
	let name: String
	let url: String
}
