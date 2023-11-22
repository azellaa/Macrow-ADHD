//
//  HideAndSeekScene.swift
//  Macrow-ADHD
//
//  Created by Priskilla Adriani on 03/10/23.
//

import SpriteKit
import GameplayKit
import Combine
import CoreData
import SwiftUI

class HideAndSeekScene: SKScene, SKPhysicsContactDelegate, TutorialDelegate {
   
   private var rabbit = SKSpriteNode()
   private var fox = SKSpriteNode()
   private var connection = SKSpriteNode()
   private var focusBar = ProgressBar()
   private var bg = BackgroundHideAndSeek()
   private var rabbitPos = [NodeElement]()
   private var foxPos = [NodeElement]()
   private var tutorialView = TutorialView()
   private var pausedPopup = SKSpriteNode()
   private var pausedLabel = SKLabelNode()
   private var disconnectPopup = SKSpriteNode()
   
   private var rabbitCount = 0
   private var isTouched = false
   
   @AppStorage("tutorialOpened") public var isTutorialOpened = true
   
   public var focusCount = 80 // focus point
   public var isSpawning = false
   private var numOfSpawn = 0
   
   var cancellables: Set<AnyCancellable> = []
   
   var listFocusData: [Double] = [Double]()
   var mwmObject = MWMInstance.shared
   
   public var isCompleted = false
   private var attentionPopup = AttentionPopup()
   
   var signalStatus: Int = 4
   var dataController: DataController!
   var context: NSManagedObjectContext!
   
   var gameEntity: Game!
   
   var reportEntity: Report!
   
   var pauseDataEntity: Pause!
   
   var disconnectDataEntity: DisconnectEntity!
   
   var currentAnimalEntity: Animal!
   
   var isSavingPauseData = false
   var isSavingDisconnectData = false
   var isPublisherStarted = false
   var firstAnimalSpawned = false
   
   @Binding var isEndGame: Bool
   let hideAndSeekLevel: GameLevelModel
   private var timerValue: Int
   
   init(size: CGSize, isEndGame: Binding<Bool>, hideAndSeekLevel: GameLevelModel) {
      _isEndGame = isEndGame
      self.hideAndSeekLevel = hideAndSeekLevel
      self.timerValue = hideAndSeekLevel.levelModel.levelDuration
      super.init(size: size)
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   override func didMove(to view: SKView) {
      dataController = DataController.shared
      self.context = dataController.container.viewContext
      
      self.gameEntity = dataController.addGame(
         gameName: hideAndSeekLevel.name,
         level: Int16(hideAndSeekLevel.levelModel.intRepresentation),
         context: self.context
      )
      self.reportEntity = dataController.addInitialReport(
         game: self.gameEntity,
         context: self.context
      )
      
      physicsWorld.contactDelegate = self
      
      scene?.size = view.bounds.size
      scene?.scaleMode = .aspectFill
      
      addRabbitPosition()
      addFoxPosition()
      
      addNodes()
      
      bg.getSceneFrame(sceneFrame: self.frame)
      bg.addBackground()
      addChild(bg)
      
      openTutorial()
      
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
         if self.timerValue <= 1 {
            timer.invalidate()
            self.timesUpFunc()
         }
         if !self.isTutorialOpened && self.signalStatus == 4 && self.mwmObject.isConnected{
            self.timerValue -= 1
         }
      }
      AudioManager.shared.playBackgroundMusic(
         fileName: ResourcePath.Sound.BackgroundMusic.gameMusic
      )
      
      openTutorial()
      
      if !isTutorialOpened {
         if !isPublisherStarted {
            self.startMWMPublisher()
            isPublisherStarted = true
         }
         
         if !firstAnimalSpawned {
            spawnEntity()
            firstAnimalSpawned = true
         }
      }
   }
   
   func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool) {
      self.isTutorialOpened = isTutorialOpened
   }
   
   //TODO: Make simultaneous spawn
   func spawnNextEntity() {
      isSpawning = false
      isTouched = false
      
      let delayAction = SKAction.wait(forDuration: self.hideAndSeekLevel.levelModel.spawnInteval)
      run(delayAction) {
         self.spawnEntity()
         
      }
   }
   
   
   func spawnEntity() {
      if isSpawning {
         return // If entities are currently spawning, exit early
      }
      
      let spawnCount = Int.random(in: 1...(hideAndSeekLevel.levelModel.maximumSpawn))
      numOfSpawn = spawnCount
      
      var spot = [0,1,2,3,4]
      
      for _ in 0..<spawnCount {
         let randomValue = Int.random(in: 1...(hideAndSeekLevel.levelModel.rabbitRatio + hideAndSeekLevel.levelModel.foxRatio))
         isSpawning = true // Mark that an entity is spawning
         
         //            let spawnCompletionAction = SKAction.run { [weak self] in
         ////                self?.spawnNextEntity()
         //            }
         
         let randomPos = Int.random(in: 0..<spot.count)
         
         if randomValue <= hideAndSeekLevel.levelModel.rabbitRatio {
            // Spawn a rabbit
            let randomRabbit = rabbitPos[spot[randomPos]]
            let rabbit = SKSpriteNode(imageNamed: randomRabbit.textureName)
            rabbit.name = "rabbit"
            rabbit.position = randomRabbit.position
            rabbit.setScale(randomRabbit.scale)
            rabbit.zPosition = randomRabbit.zIndex
            self.addChild(rabbit)
            
            // Define a slide-up action
            let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: rabbit.size.height), duration: 1.0)
            slideUpAction.timingMode = .easeIn
            
            // Define a slide-down action
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -rabbit.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn
            
            // Define a sequence of actions
            let sequence = SKAction.sequence([
               slideUpAction,
               SKAction.wait(forDuration: 5.0),
               slideDownAction,
               SKAction.removeFromParent(),
               SKAction.run{
                  self.numOfSpawn -= 1
               }
               //                    spawnCompletionAction
            ])
            
            rabbit.run(sequence, completion: {
            })
            
            currentAnimalEntity = dataController.addAnimal(
               appearTime: Date(),
               animalTypeEnum: .rabbit,
               game: self.gameEntity,
               context: self.context
            )
            
         } else {
            // Spawn a fox
            let randomFox = foxPos[spot[randomPos]]
            let fox = SKSpriteNode(imageNamed: randomFox.textureName)
            fox.name = "fox"
            fox.position = randomFox.position
            fox.setScale(randomFox.scale)
            fox.zPosition = randomFox.zIndex
            self.addChild(fox)
            
            let slideUpAction = SKAction.move(
               by: CGVector(
                  dx: 0,
                  dy: fox.size.height
               ),
               duration: 1.0)
            slideUpAction.timingMode = .easeIn
            
            let slideDownAction = SKAction.move(
               by: CGVector(
                  dx: 0,
                  dy: -fox.size.height
               ),
               duration: 1.0)
            slideDownAction.timingMode = .easeIn
            
            // Define a sequence of actions
            let sequence = SKAction.sequence([
               slideUpAction,
               SKAction.wait(forDuration: 5.0),
               slideDownAction,
               SKAction.removeFromParent(),
               SKAction.run{
                  self.numOfSpawn -= 1
               }
               //                    spawnCompletionAction
            ])
            
            fox.run(sequence, completion: {
            })
            
            currentAnimalEntity = dataController.addAnimal(
               appearTime: Date(),
               animalTypeEnum: .fox,
               game: self.gameEntity,
               context: self.context
            )
         }
         
         spot.remove(at: randomPos)
      }
   }
   
   
   func addRabbitPosition() {
      rabbitPos.append(NodeElement(name: "rabbit", textureName: ResourcePath.HideAndSeekScene.rabbitHide, position: CGPoint(x: size.width * 0.075 , y: -size.height * 0.12),  scale: 1 * 0.826, zIndex: 6))
      rabbitPos.append(NodeElement(name: "rabbit", textureName: ResourcePath.HideAndSeekScene.rabbitHide, position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6 * 0.826, zIndex: 3))
      rabbitPos.append(NodeElement(name: "rabbit", textureName: ResourcePath.HideAndSeekScene.rabbitHide, position: CGPoint(x: size.width * 0.4307 , y: size.height * 0.135), scale: 0.54 * 0.826, zIndex: 3))
      rabbitPos.append(NodeElement(name: "rabbit", textureName: ResourcePath.HideAndSeekScene.rabbitHide, position: CGPoint(x: size.width * 0.65 , y: size.height * 0.02), scale: 0.8 * 0.826, zIndex: 3))
      rabbitPos.append(NodeElement(name: "rabbit", textureName: ResourcePath.HideAndSeekScene.rabbitHide, position: CGPoint(x: size.width * 0.93 , y: -size.height * 0.08), scale: 1 * 0.826, zIndex: 5))
   }
   
   func addFoxPosition() {
      foxPos.append(NodeElement(name: "fox", textureName: ResourcePath.HideAndSeekScene.foxSeek, position: CGPoint(x: size.width * 0.073 , y: -size.height * 0.1 ), scale: 0.7 * 0.7, zIndex: 6))
      foxPos.append(NodeElement(name: "fox", textureName: ResourcePath.HideAndSeekScene.foxSeek, position: CGPoint(x: size.width * 0.268 , y: size.height * 0.01 ), scale: 0.6 * 0.7, zIndex: 3))
      foxPos.append(NodeElement(name: "fox", textureName: ResourcePath.HideAndSeekScene.foxSeek, position: CGPoint(x: size.width * 0.431 , y: size.height * 0.15 ), scale: 0.45 * 0.7, zIndex: 3))//ini
      foxPos.append(NodeElement(name: "fox", textureName: ResourcePath.HideAndSeekScene.foxSeek, position: CGPoint(x: size.width * 0.65 , y: size.height * 0.01), scale: 0.7 * 0.7, zIndex: 3))
      foxPos.append(NodeElement(name: "fox", textureName: ResourcePath.HideAndSeekScene.foxSeek, position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.15 ), scale: 1 * 0.7, zIndex: 5))
   }
   
   func addNodes() {
      tutorialView = TutorialView(sceneFrame: self.frame)
      tutorialView.isUserInteractionEnabled = true
      tutorialView.delegate = self
      tutorialView.zPosition = 20
      addChild(tutorialView)
      
      connection.position = CGPoint(x: frame.width * 0.930, y: frame.height * 0.89)
      connection.size = CGSize(width: 83, height: 79)
      connection.zPosition = 10
      addChild(connection)
      
      focusBar.getSceneFrame(sceneFrame: frame)
      focusBar.setScale(0.9)
      focusBar.buildScoreBox()
      focusBar.position = CGPoint(x: frame.width * 0.47 , y: frame.height * 0.93)
      addChild(focusBar)
      
      
      attentionPopup = AttentionPopup(sceneFrame: frame)
      attentionPopup.isShowing = false
      attentionPopup.isHidden = true
      attentionPopup.zPosition = 20
      addChild(attentionPopup)
      
      pausedPopup.addChild(pausedLabel)
      
      disconnectPopup = SKSpriteNode(imageNamed: ResourcePath.HideAndSeekScene.disconnectedPopUp)
      disconnectPopup.setScale(1)
      disconnectPopup.zPosition = 26
      disconnectPopup.position = CGPoint(x: frame.midX, y: frame.midY)
      addChild(disconnectPopup)
      disconnectPopup.alpha = 0
   }
   
   func updateIcon(_ imageName: String) -> SKTexture{
      return SKTexture(imageNamed: imageName)
   }
   
   func showPopupConnecting() {
      //        pausedPopup.texture = updateIcon("defaultBg")
      //        let moveAction = SKAction.moveTo(y: frame.midY , duration: 0.5)
      //        pausedPopup.run(moveAction)
      //        pausedPopup.alpha = 1
   }
   
   func showPopupDisconnect() {
      disconnectPopup.texture = updateIcon(ResourcePath.HideAndSeekScene.disconnectedPopUp)
      let moveAction = SKAction.moveTo(y: frame.midY , duration: 0.5)
      disconnectPopup.run(moveAction)
      disconnectPopup.alpha = 1
   }
   
   func showPopupAnimation() {
      let moveAction = SKAction.moveTo(y: frame.height * 0.91, duration: 0.5)
      pausedPopup.run(moveAction)
   }
   
   func hidePopupAnimation() {
      disconnectPopup.alpha = 0
      pausedPopup.alpha = 0
   }
   
   func openTutorial() {
      if !isTutorialOpened {
         tutorialView.isHidden = true
         self.fox.isPaused = false
         self.rabbit.isPaused = false
         self.focusBar.isPaused = false
      } else {
         tutorialView.isHidden = false
         self.fox.isPaused = true
         self.rabbit.isPaused = true
         self.focusBar.isPaused = true
      }
   }
   
   func timesUpFunc() {
      isEndGame = true
      dataController.editAvgAttentionReport(
         report: self.reportEntity,
         avgAttention: listFocusData.average(),
         context: self.context
      )
      GameData.rabbitCount = rabbitCount
      //        dataController.fetchAndPrintFocusData()
      
      self.fox.isPaused = true
      self.rabbit.isPaused = true
      attentionPopup.isHidden = true
      attentionPopup.removeFromParent()
      let scene = GameOverPage(sceneFrame: self.frame)
      scene.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
      
      scene.isUserInteractionEnabled = true
      
      let blackAlphaBackground = SKSpriteNode()
      blackAlphaBackground.size = CGSize(width: self.frame.width, height: self.frame.height)
      blackAlphaBackground.color = .black
      blackAlphaBackground.alpha = 0.5
      blackAlphaBackground.position = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2)
      
      blackAlphaBackground.zPosition = 19
      scene.zPosition = 20
      addChild(blackAlphaBackground)
      addChild(scene)
      
      
      listFocusData = [Double]()
      stopMWMPublisher()
      AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.gameOverSound)
      
      isCompleted = true
      
      AudioManager.shared.stopBackgroundMusic()
      
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
      for touch in touches {
         let location = touch.location(in: self)
         
         if !isTouched && attentionPopup.isHidden {
            //               ForEach(rabbit) { rabbit in
            //                  rabbit.contains(location)
            //
            //               }
            let node = self.nodes(at: location).first as? SKSpriteNode ?? SKSpriteNode()
            if node.name == "rabbit" {
               // Change texture for the rabbit
               node.texture = SKTexture(imageNamed: ResourcePath.HideAndSeekScene.rabbitTap)
               AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.gainStarSound)
               
               node.removeAllActions()
               rabbitCount += 1
               
               // Update rabbitCount in GameData
               GameData.rabbitCount = rabbitCount
               
               //                    isTouched = true
               
               node.run(slideSequence(y: node.size.height))
               
               dataController.editAnimalTapTime(
                  animal: self.currentAnimalEntity,
                  tapTime: Date(),
                  context: self.context
               )
            }
            
            if node.name == "fox" {
               // Change texture for the fox
               node.texture = SKTexture(imageNamed: ResourcePath.HideAndSeekScene.foxTap)
               AudioManager.shared.playSoundEffect(fileName: ResourcePath.SoundEffect.loseStarSound)
               node.removeAllActions()
               if rabbitCount - 1 <= 0 {
                  rabbitCount = 0
               } else {
                  rabbitCount -= 1
               }
               
               // Update rabbitCount in GameData
               GameData.rabbitCount = rabbitCount
               
               //                    isTouched = true
               
               node.run(slideSequence(y: node.size.height))
               
               dataController.editAnimalTapTime(
                  animal: self.currentAnimalEntity,
                  tapTime: Date(),
                  context: self.context
               )
            }
            
            print(numOfSpawn)
         }
      }
   }
   
   func slideSequence(y: CGFloat) -> SKAction {
      //        let spawnCompletionAction = SKAction.run { [weak self] in
      ////            self?.spawnNextEntity()
      //        }
      
      let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -y), duration: 2.0)
      slideDownAction.timingMode = .easeIn
      
      let sequence = SKAction.sequence([
         slideDownAction,
         SKAction.removeFromParent(),
         SKAction.run {
            self.numOfSpawn -= 1
         }
         //            spawnCompletionAction
      ])
      
      return sequence
   }
   
   func startMWMPublisher() {
      
   }
   
   func stopMWMPublisher() {
      
   }
   
   override func update(_ currentTime: TimeInterval) {
      
      if numOfSpawn < 1 {
         spawnNextEntity()
      }
      
      let minutes = timerValue / 60
      let seconds = timerValue % 60
      
      focusBar.updateProgressBar(
         CGFloat(self.focusCount),
         timeLeft: String(
            format:"%d:%02d",
            minutes,
            seconds),
         score: rabbitCount
      )
      attentionPopup.update(currentTime)
      if tutorialView.isHidden {
         if self.focusCount < 50  {
            self.fox.isPaused = true
            self.rabbit.isPaused = true
            attentionPopup.isHidden = false
            if !attentionPopup.isShowing {
               attentionPopup.startShowPause(self)
               if !isSavingPauseData {
                  pauseDataEntity = dataController.addPause(startTime: Date(), report: self.reportEntity, context: self.context)
                  isSavingPauseData = true
               }
               
               
            }
         } else if self.signalStatus != 4 || !mwmObject.isConnected{
            self.fox.isPaused = true
            self.rabbit.isPaused = true
            attentionPopup.isHidden = true
         }
         
         else if self.focusCount >= 50 {
            self.fox.isPaused = false
            self.rabbit.isPaused = false
            attentionPopup.isHidden = true
            attentionPopup.stopShowPause()
            if isSavingPauseData {
               dataController.editPauseEndTime(pause: pauseDataEntity, endTime: Date(), context: self.context)
               isSavingPauseData = false
            }
         }
      }
   }
}

protocol EndGameProtocol {
   func isEndGameOpen(_ hideAndSeekScene: HideAndSeekScene, isEndGame: Bool)
}
