import UIKit

class ViewController: UIViewController {
	
	var myApps = [AppItem]()
	@IBOutlet weak var collectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let ADS = AppDataSource()
		let appsUrl = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/50/explicit.json"
		ADS.delegate = self
		ADS.getMovies(from: appsUrl)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let s = sender as? AppCollectionViewCell else { return }
		let index = collectionView.indexPath(for: s)
		let row = index?.row
		let dest = segue.destination as? DetailsViewController
		dest?.app = myApps[row!]
	}
}

extension ViewController: UICollectionViewDataSource{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return myApps.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let row = indexPath.row
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCollectionViewCell
		cell.appName.text = myApps[row].name
		cell.appArtist.text = myApps[row].artistName
		cell.appImage.image = myApps[row].image
		cell.appImage.layer.cornerRadius = 15
		cell.appImage.layer.masksToBounds = true
		return cell
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
}

extension ViewController: AppDataDelegate{
	func appsArrived(apps: [AppItem]) {
		self.myApps = apps
		self.collectionView.reloadData()
	}
	
	
}
