//
//  FistView.swift
//  OddOrEvenGame_SnapKit
//
//  Created by Atlas on 2022/02/26.
//

import UIKit
import SnapKit
import Then

class FistView : UIView {
    var fistImageView = UIImageView().then {
        $0.image = UIImage(named: "fistImage")
        $0.contentMode = .scaleAspectFit
    }
    
    //생성자를 통해서 뷰 위치 지정
    public override init(frame:CGRect) {
        super.init(frame: frame)
        self.drawCustomUI()
    }
    
    @available(*,unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    func drawCustomUI(){
        self.backgroundColor = .white
        self.addSubview(self.fistImageView)
        
        self.fistImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.isHidden = true
    }
    /**
             Animation 이후의 event를 callback 으로 받을 수 있다. 
     */
    
    func animationEvent(completion: @escaping () -> ()){
        self.chageHiddenState()
        UIView.animate(withDuration: 1.5) {
            self.fistImageView.transform = CGAffineTransform(scaleX: 5, y: 5)
            self.fistImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        } completion: { _ in
            self.chageHiddenState()
            completion()
        }
    }
    
    func chageHiddenState(){
        self.isHidden = !self.isHidden
    }
}
