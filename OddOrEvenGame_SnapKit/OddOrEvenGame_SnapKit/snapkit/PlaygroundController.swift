//
//  PlaygroundController.swift
//  OddOrEvenGame_SnapKit
//
//  Created by Atlas on 2022/02/20.
//

import UIKit
import SnapKit
import Then

class PlaygroundController: UIViewController {
    
    var gameStartButton = UIButton(type: .custom).then {
        $0.backgroundColor = .yellow
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("GAME START", for: .normal)
        $0.addTarget(self, action: #selector(gameStartPressed), for: .touchUpInside)
    }
    
    var gameView = GameView()
    var fistView = FistView()
    //메모리 관리(leak 방지,  강한순환참조 방지) 목적으로 옵셔널 사용
    var gameViewModel: GameViewModel? = GameViewModel(defaultUserBalls: 20, defaultComBalls: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.gameStartButton)
        self.view.addSubview(self.gameView)
        self.view.addSubview(self.fistView)
        
        self.setCustomUI()
        
        guard let gameViewModel = self.gameViewModel else { return }
        gameViewModel.soundPlay(fileName: "intro")
    }
    
    //버튼 클릭시 이벤트 처리
    @objc
    func gameStartPressed(){
        guard let gameViewModel = self.gameViewModel else { return }
        if gameViewModel.gameStatus == .gameOver {
            self.gameStartButton.setTitle("GAME START", for: .normal)
            self.updateScreenByResult(result: gameViewModel.refresh())
        }else{
            //애니메이션 이벤트가 종료되면 호출이되도록 클로저를 활용
            //메모리 관리(leak 방지,  강한순환참조 방지) 목적으로 [weak self] 선언하고 self를 사용.
            self.fistView.animationEvent { [weak self]  in
                guard let self = self else { return }
                self.showPopup()
            }
        }
    }
    
}

extension PlaygroundController {

    func getWhoisWinner(betBallCount: Int,currentBallCount: Int, userChoice: SelectOption){
        guard let gameViewModel = self.gameViewModel else { return }
        
        if gameViewModel.isAvailableToCompete(betBallCount: betBallCount, currentBallCount: gameViewModel.userBallsCount) {
            self.updateScreenByResult(result: gameViewModel.getWinner(betBallCount: betBallCount, userChoice: userChoice))
        }else{
            self.warningAlert(betBallCount: betBallCount, currentBallCount: gameViewModel.userBallsCount)
        }
    }
    
    func updateScreenByResult(result: GameResult){
        gameView.updateResultText(gameResult: result)
        if result.gamtStatus == .gameOver {
            self.gameStartButton.setTitle("try again", for: .normal)
        }
    }
    
}

//팝업관련
extension PlaygroundController {
    
    func warningAlert(betBallCount: Int, currentBallCount: Int){
        var warningMsg: String = ""
        if betBallCount == 0 {
            warningMsg = "1개 이상 배팅해주세요."
        } else if currentBallCount < betBallCount {
            warningMsg = "구슬이 부족합니다."
        }
        let warningAlert = UIAlertController.init(title: "앗!", message: warningMsg, preferredStyle: .alert)
        
        let confirmBtn = UIAlertAction.init(title: "다시 배팅하기", style: .default) {
            _ in self.showPopup()
        }
        
        warningAlert.addAction(confirmBtn)
        
        self.present(warningAlert, animated: true)
    }
    
    func showPopup(){
        
        let alert = UIAlertController.init(title: "Game Start!", message: "홀 짝을 선택해주세요.", preferredStyle: .alert)
        
        //메모리 관리(leak 방지, 강한순환참조 방지) 목적으로 [weak self] 선언하고 self를 사용.
        let oddBtn = UIAlertAction.init(title: "홀", style: .default) { [weak self] _ in
            
            guard let self = self, let gameViewModel = self.gameViewModel else { return }
            gameViewModel.soundPlay(fileName: "click")
            
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            
            self.getWhoisWinner(betBallCount: value,currentBallCount: gameViewModel.userBallsCount, userChoice: .odd)
            
        }
        
        let evenBtn = UIAlertAction.init(title: "짝", style: .default) { [weak self] _ in
           
            guard let self = self, let gameViewModel = self.gameViewModel else { return }
            gameViewModel.soundPlay(fileName: "click")
            
            let input: String = alert.textFields?.first?.text ?? "0"
            let value: Int = Int(input) ?? 0
            self.getWhoisWinner(betBallCount: value,currentBallCount: gameViewModel.userBallsCount, userChoice: .even)
        }
        
        alert.addAction(oddBtn)
        alert.addAction(evenBtn)
        alert.addTextField { textField in
            textField.placeholder = "배팅할 구슬의 수"
        }
        
        self.present(alert, animated: true)
        
    }
}
//화면 배치 관련
extension PlaygroundController {
    //ViewController에 보여질 화면 구성
    func setCustomUI(){
        
        self.gameStartButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        self.gameView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.gameStartButton.snp.top)
        }
        
        self.fistView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    
}
