
import Foundation
import UIKit


extension UIView {
    // UIViewからUIImageに変換する
    func getImage() -> UIImage {

        // キャプチャする範囲を取得する
        let rect = self.bounds

        // ビットマップ画像のcontextを作成する
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context : CGContext = UIGraphicsGetCurrentContext()!

        // view内の描画をcontextに複写する
        self.layer.render(in: context)

        // contextのビットマップをUIImageとして取得する
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!

        // contextを閉じる
        UIGraphicsEndImageContext()

        return image
    }

    // viewをimageに変換しカメラロールに保存する
    func save() {

        // viewをimageとして取得
        let image : UIImage = self.getImage()

        // カメラロールに保存する
        UIImageWriteToSavedPhotosAlbum(image,
                                       self,
                                       #selector(self.didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
    }

    // 保存を試みた結果を受け取る
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {


        // 結果によって出すアラートを変更する
//        var title = "保存完了"
//        var message = "カメラロールに保存しました"
//
//        if error != nil {
//            title = "エラー"
//            message = "保存に失敗しました"
//        }
//
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
    }
}
