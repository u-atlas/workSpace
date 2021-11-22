//
//  ViewController.swift
//  LifeCycle
//
//  Created by Dongju on 2021/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("뷰가 로드되었습니다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("뷰가 나타날것입니다.")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("뷰가 나타났습니다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("뷰가 사라질 것입니다.")
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("뷰가 사라졌습니다.")
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondController") as SecondController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

