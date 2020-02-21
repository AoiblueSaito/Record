//
//  PostViewController.swift
//  Record
//
//  Created by Aoi Saito on 2019/06/28.
//  Copyright © 2019年 Aoi Saito. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITableViewDataSource  {
    
    var recievedNumber: Int!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    var savedArray: [String]!
    var originalArray: [String]!
    let userDefaults = UserDefaults.standard
    @IBOutlet var table: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var inputText: UITextView!
    @IBOutlet weak var outputText: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var allDeleteButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2
        //データソース
        table.dataSource = self
        //背景色
        switch recievedNumber {
        case 0:
            self.view.backgroundColor = UIColor.blue
            label.text = "最高"
            savedArray = userDefaults.array(forKey: "最高") as? [String]
            label.textColor = UIColor.white
            allDeleteButton.setTitleColor(UIColor.white, for: .normal)
            
        case 1:
            self.view.backgroundColor = UIColor.pink
            label.text = "楽しい"
            savedArray = userDefaults.array(forKey: "楽しい") as? [String]
            label.textColor = UIColor.white
            
        case 2:
            self.view.backgroundColor = UIColor.green
            label.text = "悲しい"
            savedArray = userDefaults.array(forKey: "悔しい") as? [String]
            label.textColor = UIColor.black
            
        case 3:
            self.view.backgroundColor = UIColor.yellow
            label.text = "悔しい"
            savedArray = userDefaults.array(forKey: "悲しい") as? [String]
            label.textColor = UIColor.black
            backButton.setTitleColor(UIColor.black, for: .normal)
            
        default:
            break
        }
        super.viewDidLoad()
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let customArray = UserDefaults.standard.array(forKey: "custom") {
            originalArray = customArray as! [String]
            
            switch recievedNumber {
            case 0:
                label.text = originalArray[0]
                savedArray = userDefaults.array(forKey: originalArray[0]) as? [String]
                
            case 1:
                label.text = originalArray[1]
                savedArray = userDefaults.array(forKey: originalArray[1]) as? [String]
                
            case 2:
                label.text = originalArray[2]
                savedArray = userDefaults.array(forKey: originalArray[2]) as? [String]

            case 3:
                label.text = originalArray[3]
                savedArray = userDefaults.array(forKey: originalArray[3]) as? [String]
            default:
                break
            }
        }
    }

   //タッチで閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        outputText.text = inputText.text
        self.view.endEditing(true)
    }
    
//    override func viewDidLoada(){
//        super.viewDidLoad()
// textView.layer.cornerRadius = 10.0
// textView.layer.masksToBounds = true
//    }
//    //       table.borderStyle = .None
//     table.layer.cornerRadius = 5
//     table.layer.borderColor = UIColor.lightGrayColor().CGColor
//     table.layer.borderWidth  = 1
//     table.layer.masksToBounds = true
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
        
    }
   
    //保存の話
    @IBAction func save() {
        if textView.text != "" {
            if savedArray == nil {
                savedArray = []
            }
//            savedArray.append(textView.text)
            //現在のdateを取得して、stringに変換
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日"
            let dateStr: String = formatter.string(from: Date())
            
            savedArray.append(dateStr + "   \(textView.text ?? "")")
            
            switch recievedNumber {
            case 0:
                userDefaults.set(savedArray, forKey: "最高")
                
            case 1:
                userDefaults.set(savedArray, forKey: "楽しい")
                
            case 2:
                userDefaults.set(savedArray, forKey: "悔しい")
                
            case 3:
                userDefaults.set(savedArray, forKey: "悲しい")
                
            default:
                break
            }
            
            table.reloadData()
            textView.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nilに対応
        guard  let savedArray = savedArray else {
            return 0
        }
        
        return savedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        
        //nil対策,行拡張
        guard var _savedArray = savedArray else {
            return cell!
        }
        _savedArray.reverse()
        
        cell?.textLabel?.text = _savedArray[indexPath.row]
        cell?.textLabel?.lineBreakMode = .byCharWrapping
        cell?.textLabel?.numberOfLines = 0;
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            savedArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
           
            //削除をuserdefaultsに保存
            switch recievedNumber {
            case 0:
                userDefaults.set(savedArray, forKey: "最高")
                
            case 1:
                userDefaults.set(savedArray, forKey: "楽しい")
                
            case 2:
                userDefaults.set(savedArray, forKey: "悔しい")
                
            case 3:
                userDefaults.set(savedArray, forKey: "悲しい")
                
            default:
                break
            }
        }
    }
   
    //一括削除
    @IBAction func allDelete() {
       //alertをだす
        let alert: UIAlertController = UIAlertController(title: "一括削除", message: "削除してもいいですか", preferredStyle:  UIAlertController.Style.alert)
    
        //okボタン
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: { action in //ボタンが押された時の動作
                                        print("OKボタンが押されました")
                                        self.savedArray = []
                                        self.table.reloadData()
                                        
                                        switch self.recievedNumber {
                                        case 0:
                                            UserDefaults.standard.removeObject(forKey: "最高")
                                            
                                        case 1:
                                            UserDefaults.standard.removeObject(forKey: "楽しい")
                                            
                                        case 2:
                                            UserDefaults.standard.removeObject(forKey: "悔しい")
                                            
                                        case 3:
                                            UserDefaults.standard.removeObject(forKey: "悲しい")
                                            
                                        default:
                                            break
                                        }
        })
        //cancelボタン
        let cancelAction = UIAlertAction(title: "cancel",
                                         style: .cancel,
                                         handler: { action in //ボタンが押された時の動作
                                            print("cancelボタンが押されました")
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    
    }
}


