//
//  EditViewController.swift
//  Record
//
//  Created by Aoi Saito on 2019/11/01.
//  Copyright © 2019年 Aoi Saito. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    let ud = UserDefaults.standard
    
    var defaultArray: [String] = ["最高", "嬉しい", "悔しい", "悲しい"]
    var newArray: [String] = ["最高", "嬉しい", "悔しい", "悲しい"]
    
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var textField0: UITextField!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    

    override func viewDidLoad(){
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //ud読み込み
        if let customArray = ud.array(forKey: "custom") {
            defaultArray = customArray as! [String]
        }
        //読み込んだLabelをlabelに表示
        label0.text = defaultArray[0]
        textField0.placeholder = defaultArray[0]
        label1.text = defaultArray[1]
        textField1.placeholder = defaultArray[1]
        label2.text = defaultArray[2]
        textField2.placeholder = defaultArray[2]
        label3.text = defaultArray[3]
        textField3.placeholder = defaultArray[3]
        
    }
    
    @IBAction func save() {
        //値をudに保存
        // UserDefaultsの参照
        
        if !(textField0.text?.isEmpty)! {
            defaultArray[0] = textField0.text ?? ""
        }
        
        if !(textField1.text?.isEmpty)! {
            defaultArray[1] = textField1.text ?? ""
        }
        
        if !(textField2.text?.isEmpty)! {
            defaultArray[2] = textField2.text ?? ""
        }
        
        if !(textField3.text?.isEmpty)! {
            defaultArray[3] = textField3.text ?? ""
        }

        //保存する
        ud.set(defaultArray, forKey: "custom")
        
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
        
    }
    //キーボード閉じ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textField0.text = textField0.text
//        textField1.text = textField1.text
//        textField2.text = textField2.text
//        textField3.text = textField3.text
//
        self.view.endEditing(true)
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
//        textField0.text = textField0.text
//        textField1.text = textField1.text
//        textField2.text = textField2.text
//        textField3.text = textField3.text
        return true
    }

}
