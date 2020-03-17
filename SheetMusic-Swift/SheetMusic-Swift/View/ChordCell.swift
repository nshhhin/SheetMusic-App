
import Foundation
import UIKit

class ChordCell: UITableViewCell {

    let numOfRow = 4

    var chords: [String] = []

    var selectedChord: String = "None"

    @IBOutlet weak var chordCollectionV: UICollectionView! {
        didSet {
            chordCollectionV.delegate = self
            chordCollectionV.dataSource = self
            chordCollectionV.register(cellType: ChordFigureCell.self)
        }
    }

    override func awakeFromNib() {
        for i in 0..<numOfRow {
            chords.append("None")
        }
    }

    func setChord(_ chord: String){
        selectedChord = chord
        chordCollectionV.reloadData()
    }

    func setLayout(_ height: CGFloat){

        let width = self.bounds.width / CGFloat(numOfRow)
        
        var size: CGFloat = 0

        if width < height {
            size = width
        } else {
            size = height
        }


        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = (width - CGFloat(numOfRow) * size)/CGFloat(numOfRow+2)

        chordCollectionV.setCollectionViewLayout(layout, animated: false)
    }

}

extension ChordCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfRow
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print( indexPath.row, "タップされた" )
        chords[indexPath.row] = selectedChord
        chordCollectionV.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if chords[indexPath.row] != "None" {
            let cell = collectionView.dequeueReusableCell(with: ChordFigureCell.self, for: indexPath) as! ChordFigureCell
            cell.chordImageV.image = UIImage(named: chords[indexPath.row])
            return cell
        }

       let cell = collectionView.dequeueReusableCell(with: ChordFigureCell.self, for: indexPath) as! ChordFigureCell
       cell.chordImageV.image = nil
       return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let width = self.contentView.frame.width / CGFloat(numOfRow)
        let returnSize = CGSize(width: width, height: width)
        return returnSize
    }

}




