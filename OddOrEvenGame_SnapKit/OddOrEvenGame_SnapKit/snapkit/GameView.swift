//
//  GameView.swift
//  OddOrEvenGame_SnapKit
//
//  Created by Atlas on 2022/02/21.
//

import UIKit
import SnapKit
import Then


class GameView: UIView {
    
    //전체 스택뷰
    private var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 7
    }
    //computer 이미지
    private var comImage = UIImageView().then {
        $0.image = UIImage(named: "comImage")
        $0.contentMode = .scaleAspectFit
    }
    //사용자 이미지
    private var userImage = UIImageView().then {
        $0.image = UIImage(named: "userImage")
        $0.contentMode = .scaleAspectFit
    }
    //경기내용 표기할 label 스택뷰
    private var gameInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 7
    }
    
    private var computerBallCountLbl = UILabel().then {
        $0.text = "남은 구슬 갯수 : 20개"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    private var userBallCountLbl = UILabel().then {
        $0.text = "남은 구슬 갯수 : 20개"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 17)
    }
    
    private var resultbl = UILabel().then {
        $0.text = "결과화면"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 30)
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
        self.addSubview(self.containerStackView)
        
        self.gameInfoStackView.addArrangedSubview(self.computerBallCountLbl)
        self.gameInfoStackView.addArrangedSubview(self.resultbl)
        self.gameInfoStackView.addArrangedSubview(self.userBallCountLbl)
        
        self.containerStackView.addArrangedSubview(self.comImage)
        self.containerStackView.addArrangedSubview(self.gameInfoStackView)
        self.containerStackView.addArrangedSubview(self.userImage)
        
        self.containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
}

extension GameView {
    func updateResultText(gameResult: GameResult){
        
        self.userBallCountLbl.text = gameResult.userCount
        self.computerBallCountLbl.text = gameResult.comCount
        self.userBallCountLbl.text = gameResult.userCount

        //way 1 if문을 사용
        /*
        if gameResult.gamtStatus == .gameOver {
            self.resultbl.text = "\(gameResult.winner!) 최종 승리!"
        }else{
            self.resultbl.text = gameResult.resultMessage
        }
         */
        
        //way 2 switch 문을 사용
        /*
        switch gameResult.gamtStatus {
        case .onGoing:
            self.resultbl.text = gameResult.resultMessage
        case .gameOver:
            self.resultbl.text = "\(gameResult.winner!) 최종 승리!"
        }
         */
        
        //way 3 Elvis Operator (삼항연산자) 사용
        self.resultbl.text = gameResult.gamtStatus == .gameOver ? "\(gameResult.winner!) 최종 승리!" : gameResult.resultMessage
        
    }
}
