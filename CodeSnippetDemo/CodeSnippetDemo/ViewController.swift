//
//  ViewController.swift
//  CodeSnippetDemo
//
//  Created by Dongju on 2022/02/05.
//
/*
 1. 마우스 우클릭 하여 'create code snippet' 클릭
 2. Spinnet을 생성
 스니펫 이름
 Summary 스니펫의 내용
 스니펫 사용시 불러올 소스코드
 Completion: 자동완성 키워드
 3. Done 클릭
 4. 자동완성으로 사용해보기

#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
 이코드를 복사해주세요.
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let green = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        switch color {
        case black:
            print("black")
        case green:
            print("green")
        case white:
            print("white")
        default:
            print("default")
        }

        //감사합니다 :)


        
    }


}

