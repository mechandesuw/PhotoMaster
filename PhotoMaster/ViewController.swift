//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 山谷美咲生 on 2019/04/14.
//  Copyright © 2019 山谷美咲生. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // 写真表示用ImageView
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view,typically from anib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //「カメラ」ボタンを押したときに呼ばれるメソッド
    @IBAction func onTappedCameraButton() {
      presentPickerController(sourceType: .camera)
       
    }
    //「アルバムボタンを押したときに呼ばれるメソッド
    
    @IBAction func onTappedAlbumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    //カメラ、アルバムの呼び出しメソッド（カメラorアルバムのソースタイプが引数）
    func presentPickerController(sourceType:UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
        }
    }
    //写真が選択された時に呼ばれるメソッド
    func imagePickerController(_picker:UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
        self.dismiss(animated: true, completion: nil)
        //画像を出力
        photoImageView.image = info[.originalImage]as?UIImage
    }
    
    //元の画像にテキストを合成するメソッド
    func drawText(image: UIImage) -> UIImage{
        
        //テキストの内容の設定
        let text = "LifeisTech"
        
        //textFontAttributes: 文字の特性[フォントとサイズ、カラー、スタイルの設定]
        let textFontAttributes = [
            NSAttributedString.Key.font: UIFont(name:"Arial",size: 120)!,
            NSAttributedString.Key.foregroundColor: UIColor.red
        ]
        
        //グラフィックコンテキスト生成編集を開始
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
    
        //定義　CGRect(x:[左からのx座標]px,y:[上からのy座標]px,width: [横の長さ]px,height:[縦の長さ]px）
        let margin: CGFloat = 0.5 //余白
        let textRect = CGRect(x: margin, y: margin, width: image.size.width - margin, height: image.size.height - margin)
        
        //textRectで指定した範囲にtextFontAttributesに従ってtextを描き出す
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        //グラフィックスコンテキストの画像を取得
        let newImage = UIGraphicsGetImageFromCurrenImageContext()
        
        //グラフィックスコンテキストの編集を終了
        UIGraphicsEndaimageContext()
        
        return newImage!
        
    }
    
    
}

