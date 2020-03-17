//
//  ViewController.swift
//  SheetMusic-Swift
//
//  Created by 新納真次郎 on 2020/01/18.
//  Copyright © 2020 新納真次郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var titleField: UITextField! {
        didSet {
            titleField.delegate  = self
            titleField.attributedPlaceholder = NSAttributedString(
                string: "曲名を入力してください",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
            )
        }
    }

    @IBOutlet weak var artistField: UITextField! {
        didSet {
            artistField.delegate = self
            artistField.attributedPlaceholder = NSAttributedString(
                string: "アーティスト名を入力してください",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray]
            )
        }
    }

    var initialChordArray = ["A", "B", "C", "D", "E", "F", "G"]

    var chordArray: [[String]] = []

    @IBOutlet weak var chordFigure: UIImageView!

    @IBOutlet weak var chordPicker: UIPickerView! {
        didSet {
            chordPicker.delegate = self
            chordPicker.dataSource = self
        }
    }

    // lyric and chord table
    @IBOutlet weak var lacTableView: UITableView! {
        didSet {
            lacTableView.delegate = self
            lacTableView.dataSource = self

            // 歌詞セルとコードセルの2つにカスタムセルを登録する
            lacTableView.register(cellType: LyricCell.self)
            lacTableView.register(cellType: ChordCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        chordArray = appDelegate.chordArray
    }


    @IBAction func addBtnTapped(_ sender: Any) {
        
    }

}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return chordArray.count
            case 1:
                let row0 = pickerView.selectedRow(inComponent: 0)
                return chordArray[row0].count
            default:
                return 0
        }
    }

    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch component {
        case 0:
            return initialChordArray[row]
        case 1:
            let row0: Int = pickerView.selectedRow(inComponent: 0)
            return chordArray[row0][row]
        default:
            return nil
        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            // 重要: 左のぴっかーが変えられたら右は0番目にしなくてはならない!!
            chordPicker.selectRow(0, inComponent: 1, animated: false)
            let row1: Int = chordPicker.selectedRow(inComponent: 1)
            let selectedChord = chordArray[row][row1]
            let image = UIImage(named: selectedChord)
            chordPicker.reloadComponent(1)
            chordFigure.image = image
        case 1:
            let row0: Int = chordPicker.selectedRow(inComponent: 0)
            let selectedChord = chordArray[row0][row]
            let image = UIImage(named: selectedChord)
            chordFigure.image = image
        default:

            break
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        switch indexPath.row % 2 {
            case 0:
                let cell = tableView.dequeueReusableCell(with: ChordCell.self, for: indexPath) as ChordCell
                cell.setLayout(70)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(with: LyricCell.self, for: indexPath) as LyricCell
                return cell
            default:
                break
        }

        let cell = tableView.dequeueReusableCell(with: LyricCell.self, for: indexPath) as LyricCell
        return cell
    }

    // FIXME: 押されたて判定がない.....なぜ....
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        print( "\(indexPath.row)のテーブルがタップされた")
        let row0: Int = chordPicker.selectedRow(inComponent: 0)
        let row1: Int = chordPicker.selectedRow(inComponent: 1)
        let selectedChord = chordArray[row0][row1]

        let cell = tableView.dequeueReusableCell(with: ChordCell.self, for: indexPath) as ChordCell
        cell.setChord(selectedChord)

        lacTableView.reloadData()

        return indexPath
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 70
        }

        return 30
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
