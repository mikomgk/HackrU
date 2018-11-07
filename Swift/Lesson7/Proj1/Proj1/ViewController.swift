import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var table: UITableView!
	var mySongs = [ItunesItem]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let songsUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
		let ds = ItunesDataSource()
		ds.getSongs(from: songsUrl) { songs in
			print(songs)
			self.mySongs = songs
			self.table.reloadData()
		}
	}

//	let important = DispatchQueue.global(qos: .userInteractive)
//	let d = DispatchQueue.global(qos: .userInitiated)

}

extension ViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return mySongs.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = indexPath.row
		let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell")
		cell?.textLabel?.text = mySongs[row].name
		cell?.detailTextLabel?.text = mySongs[row].artistName
		cell?.imageView?.image = mySongs[row].artworkUrl100
		return cell!
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}

extension ViewController: UITableViewDelegate{
	
}

