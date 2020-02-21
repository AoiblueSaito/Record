//
//  ViewController.swift
//  Record
//
//  Created by Aoi Saito on 2019/06/21.
//  Copyright © 2019年 Aoi Saito. All rights reserved.
//

import UIKit
import BubbleTransition

class ViewController: UIViewController {
    
    //　手順②
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var pinkButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var edit: UIView!
    
    
    //　手順③
    let transition = BubbleTransition()
    var checker: Int = 0
    
    var defaultArray: [String] = ["最高", "楽しい", "悔しい", "悲しい"]
    let ud = UserDefaults.standard

    

    override func viewDidLoad() {
        super.viewDidLoad()
//        blueButton.layer.cornerRadius = blueButton.frame.size.height / 2
//        pinkButton.layer.cornerRadius = pinkButton.frame.size.height / 2
//        greenButton.layer.cornerRadius = greenButton.frame.size.height / 2
//        yellowButton.layer.cornerRadius = yellowButton.frame.size.height / 2
//        editButton.layer.cornerRadius = yellowButton.frame.size.height / 2
        
//        guard let customArray = UserDefaults.standard.array(forKey: "custom") else {
//            return
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blueButton.layer.cornerRadius = blueButton.frame.size.height / 2
        pinkButton.layer.cornerRadius = pinkButton.frame.size.height / 2
        greenButton.layer.cornerRadius = greenButton.frame.size.height / 2
        yellowButton.layer.cornerRadius = yellowButton.frame.size.height / 2
        editButton.layer.cornerRadius = yellowButton.frame.size.height / 2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let customArray = UserDefaults.standard.array(forKey: "custom") else {
            return
        }
        defaultArray = customArray as! [String]
        
        blueButton.setTitle(defaultArray[0], for: .normal)
        pinkButton.setTitle(defaultArray[1], for: .normal)
        greenButton.setTitle(defaultArray[2], for: .normal)
        yellowButton.setTitle(defaultArray[3], for: .normal)
    }
        
    
    
    @IBAction func blueButtonTapped() {
       checker = 0
        performSegue(withIdentifier: "toPost", sender: 0)
        
    }
    
    @IBAction func pinkButtonTapped() {
        checker = 1
        performSegue(withIdentifier: "toPost", sender: 1)
        
    }
    @IBAction func greenButtonTapped() {
        checker = 2
        performSegue(withIdentifier: "toPost", sender: 2)
        
    }
    @IBAction func yellowButtontapped() {
        checker = 3
        performSegue(withIdentifier: "toPost", sender: 3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPost" {
            let postViewController = segue.destination as! PostViewController
            postViewController.recievedNumber = sender as? Int
            postViewController.transitioningDelegate = self
            postViewController.modalPresentationStyle = .custom
        }
   }
}

extension ViewController : UIViewControllerTransitioningDelegate{
    
    //　手順⑤
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        switch checker {
        case 0:
            transition.startingPoint = startPoint(blueButton) //outletしたボタンの名前を使用
            transition.bubbleColor = UIColor.blue        //円マークの色
       
        case 1:
            transition.startingPoint = startPoint(pinkButton)
            transition.bubbleColor = UIColor.pink       //円マークの色
            
       
        case 2:
            transition.startingPoint = startPoint(greenButton)
            transition.bubbleColor = UIColor.green        //円マークの色
           
      
        case 3:
            transition.startingPoint = startPoint(yellowButton)
            transition.bubbleColor = UIColor.yellow       //円マークの色
            
        
        default:
            break
        }
        print(transition.startingPoint)
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        switch checker {
        case 0:
            transition.startingPoint = startPoint(blueButton) //outletしたボタンの名前を使用
            transition.bubbleColor = UIColor.blue    //円マークの色
        
        case 1:
        transition.startingPoint = startPoint(pinkButton) //outletしたボタンの名前を使用
        transition.bubbleColor = UIColor.pink   //円マークの色
            
        case 2:
        transition.startingPoint = startPoint(greenButton) //outletしたボタンの名前を使用
        transition.bubbleColor = UIColor.green   //円マークの色
            
        case 3:
        transition.startingPoint = startPoint(yellowButton) //outletしたボタンの名前を使用
        transition.bubbleColor = UIColor.yellow  //円マークの色
        default:
            break
        }
        //        transition.startingPoint = blueButton.center //outletしたボタンの名前を使用
        //        transition.bubbleColor = UIColor.blue    //円マークの色
                return transition
    }

    func startPoint(_ button: UIButton) -> CGPoint {
        let superView = button.superview?.frame.origin ?? CGPoint(x: 0, y: 0)
        let superSuperView = button.superview?.superview!.frame.origin ?? CGPoint(x: 0, y: 0)
        return superView + button.frame.origin + button.center + superSuperView
    }
}

private extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    } 

}
