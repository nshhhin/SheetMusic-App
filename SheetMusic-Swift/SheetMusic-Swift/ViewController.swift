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

    var initialChordArray = ["A", "B", "C", "D", "E", "F", "G"]

    var chordArray: [[String]] = []

    @IBOutlet weak var chordFigure: UIImageView!

    @IBOutlet weak var chordPicker: UIPickerView! {
        didSet {
            chordPicker.delegate = self
            chordPicker.dataSource = self
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        chordArray = appDelegate.chordArray
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
                let row0 = chordPicker.selectedRow(inComponent: 0)
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
            let row0: Int = chordPicker.selectedRow(inComponent: 0)
            return chordArray[row0][row]
        default:
            return nil
        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print("更新したよ")

        switch component {
        case 0:
            let row1: Int = chordPicker.selectedRow(inComponent: 1)
            let selectedChord = chordArray[row][row1]
            let image = UIImage(named: selectedChord + ".png")
            chordPicker.reloadComponent(1)
            chordFigure.image = image
        case 1:
            let row0: Int = chordPicker.selectedRow(inComponent: 0)
            let selectedChord = chordArray[row0][row]
            let image = UIImage(named: selectedChord + ".png")
            chordFigure.image = image
        default:

            break
        }


    }


}


