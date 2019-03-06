
import UIKit

class ConversationViewCell: UITableViewCell {
    
    
    weak var delegate: MessageCellConfiguration?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

protocol MessageCellConfiguration : class {
    var text: String? {get set}
}


