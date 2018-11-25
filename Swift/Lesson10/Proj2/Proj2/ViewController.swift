import UIKit

class ViewController: UIViewController {

	var collectionVC: IconsCollectionViewController? = nil
	@IBOutlet weak var itemLbl: UILabel!
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var iconImage: UIImageView!
	@IBOutlet weak var containerHeight: NSLayoutConstraint!
	var isMenuOpen: Bool{
		return self.containerHeight.constant > 0
	}
	lazy var height = {
		return collectionVC?.collectionHeight ?? CGFloat(150)
	}()
	@IBAction func showContainer(_ sender: Any) {
		self.containerHeight.constant = isMenuOpen ? 0 : height
//		UIView.animate(withDuration: 0.3) {
//			self.view.layoutIfNeeded()
//		}
		UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 30, options: .curveEaseIn, animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		containerHeight.constant = 0
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		collectionVC = segue.destination as? IconsCollectionViewController
		collectionVC?.delegate = self
	}
}

extension ViewController: IconsCollectionViewControllerDelegate{
	func didSelectItem(_ item: IconItem) {
		itemLbl.text = item.name.toCapital()
		iconImage.image = item.image
	}
}

struct IconItem{
	let name: Pokemon
	let image: UIImage
}
