import UIKit

class ItunesDataSource{
	var session: URLSession?
	
	func getSongs(from urlSource: String, doAfter callback: @escaping ([ItunesItem]) -> ()){
		guard let url = URL(string: urlSource) else{ return }
		session = URLSession(configuration: .default)
		let task = session?.dataTask(with: url) { (data, res, err) in
			if let err = err{
				print(err)
				return
			}
			guard let d = data else{ return }
			guard let dataJSON = try? JSONSerialization.jsonObject(with: d, options: []) as? JSONObject else { return }
			let f = dataJSON!["feed"] as? JSONObject
			let songsJSON = f!["results"] as? JSONArray
			var songs = [ItunesItem]()
			for songJSON in songsJSON!{
				let artistName = songJSON["artistName"] as! String
				let releaseDate = songJSON["releaseDate"] as! String
				let name = songJSON["name"] as! String
				let artistUrl = songJSON["artistUrl"] as! String
				let artworkUrl100 = songJSON["artworkUrl100"] as! String
				let image = getImage(urlSource: artworkUrl100)
				let url = songJSON["url"] as! String
				songs.append(ItunesItem(artistName: artistName, releaseDate: releaseDate, name: name, artistUrl: artistUrl, artworkUrl100: image, url: url))
			}
			DispatchQueue.main.async {
				callback(songs)
			}
		}
		task?.resume()
	}
	
	func getImage(urlSource: String) -> UIImage{
		var imageData = Data()
		guard let url = URL(string: urlSource) else{ return UIImage() }
		let task = session.dataTask(with: url) { (data, res, err) in
			if let err = err{
				print(err)
				return
			}
			guard let d = data else{ return }
			let x = UIImage(data: d) ?? UIImage()
			imageData = d
			print(d)
		}
		task.resume()
		repeat{
			continue
		}while(task.state != .completed)
		let x = UIImage(data: imageData) ?? UIImage()
		return x
	}
}

typealias JSONObject = [String: Any]
typealias JSONArray = [JSONObject]
