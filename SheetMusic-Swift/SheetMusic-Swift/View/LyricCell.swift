
import Foundation
import UIKit

class LyricCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
            textField.attributedPlaceholder = NSAttributedString(
                string: "歌詞を入力してください",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
            )
        }
    }

}

extension LyricCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
