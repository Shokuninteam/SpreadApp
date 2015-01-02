import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet var content: UILabel!
    
    @IBOutlet var count: UILabel!
    
    @IBOutlet var tags: UILabel!
    
    @IBOutlet var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
