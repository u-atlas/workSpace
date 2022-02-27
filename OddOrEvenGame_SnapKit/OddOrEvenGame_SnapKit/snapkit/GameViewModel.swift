//
//  GameViewModel.swift
//  OddOrEvenGame_SnapKit
//
//  Created by Atlas on 2022/02/26.
//

import UIKit
import AVFoundation

enum GameStatus {
    case onGoing
    case gameOver
}

enum SelectOption: String {
    case odd = "홀"
    case even = "짝"
    
    func toString() -> String {
        return self.rawValue
    }
}

enum Player: String {
    case com = "Computer"
    case user = "User"
}

//ViewModel 생성
class GameViewModel {
    var userBallsCount: Int
    var comBallsCount: Int
    var gameStatus: GameStatus = .onGoing
    var player: AVAudioPlayer?
    
    init(defaultUserBalls: Int , defaultComBalls:Int){
        self.userBallsCount = defaultUserBalls
        self.comBallsCount = defaultComBalls
    }
    
}

extension GameViewModel {
    func refresh() -> GameResult{
        self.gameStatus =  .onGoing
        self.userBallsCount = 20
        self.comBallsCount = 20
        
        return GameResult(
            userCount: "\(self.userBallsCount)",
            comCount: "\(self.comBallsCount)",
            resultMessage:  "결과 화면",
            winner: nil,
            gamtStatus: self.gameStatus)
    }
    
    func isAvailableToCompete(betBallCount: Int, currentBallCount: Int) -> Bool {
        return (betBallCount != 0 && currentBallCount >= betBallCount)
    }
    
    func getWinner(betBallCount: Int, userChoice: SelectOption) -> GameResult {
        
        let comNumber = getRandom()
        let comType = comNumber % 2 == 0 ? SelectOption.even : SelectOption.odd
        let winner = userChoice == comType ? Player.user : Player.com
        self.gameStatus =  self.calculateBalls(winner: winner, betBallCount: betBallCount)
        return GameResult(
            userCount: "\(self.userBallsCount)",
            comCount: "\(self.comBallsCount)",
            resultMessage:  "\(comType.toString())! \(winner) win!",
            winner: winner,
            gamtStatus: self.gameStatus)
    }
     func calculateBalls(winner: Player, betBallCount: Int) -> GameStatus {
        if winner == .user {
            if checkPocketEmpty(balls: self.comBallsCount - betBallCount) {
                self.userBallsCount += self.comBallsCount
                self.comBallsCount = 0
                return .gameOver
            } else {
                self.comBallsCount -= betBallCount
                self.userBallsCount += betBallCount
                return .onGoing
            }
            
        } else {
            if checkPocketEmpty(balls: self.userBallsCount - betBallCount) {
                self.comBallsCount = self.comBallsCount + betBallCount
                self.userBallsCount = 0
                return .gameOver
            } else {
                self.userBallsCount -= betBallCount
                self.comBallsCount += betBallCount
                return .onGoing
            }
        }
    }
    
    func checkPocketEmpty(balls: Int) -> Bool {
        return balls <= 0
    }
    
    private func getRandom() -> Int {
        return Int(arc4random_uniform(10)) + 1
    }
}

extension GameViewModel {
    func soundPlay(fileName: String) {
        guard let filePath = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        print("filePath: \(filePath)")
        do {
            self.player = try AVAudioPlayer(contentsOf: filePath)

            guard let soundPlayer = self.player else {
                return
            }
            soundPlayer.prepareToPlay()
            soundPlayer.setVolume(0.1, fadeDuration: 0)
            soundPlayer.play()
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}
