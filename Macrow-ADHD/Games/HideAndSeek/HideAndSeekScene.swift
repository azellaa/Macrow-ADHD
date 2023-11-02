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
    private var isTutorialOpened = false
    private var timerValue: Int = 60*3 // timer 10 menit
    
    public var focusCount = 80 // focus point
    public var isSpawning = false
    
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
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        dataController = DataController.shared
        self.context = dataController.container.viewContext
        
        self.gameEntity = dataController.addGame(gameName: "Hide & Seek", level: 1, context: self.context)
        
        
        self.reportEntity = dataController.addInitialReport(game: self.gameEntity, context: self.context)
        
        physicsWorld.contactDelegate = self
        
        scene?.size = view.bounds.size
        scene?.scaleMode = .aspectFill
        
        addRabbitPosition()
        addFoxPosition()
        
        addNodes()
        
        bg.getSceneFrame(sceneFrame: frame)
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
        
        
    }
    
    func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool) {
        self.isTutorialOpened = isTutorialOpened
    }
    
    
    func spawnNextEntity() {
        isSpawning = false
        isTouched = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if !self!.isCompleted {
                self?.spawnEntity()
            }
        }
    }
    
    func spawnEntity() {
        if isSpawning {
            return // If an entity is currently spawning, exit early
        }
        
        let randomValue = Int.random(in: 1...6) // 5:1 ratio
        isSpawning = true // Mark that an entity is spawning
        
        let spawnCompletionAction = SKAction.run { [weak self] in
            self?.spawnNextEntity()
        }
        
        if randomValue <= 5 {
            // Spawn a rabbit
            guard let randomRabbit = rabbitPos.randomElement() else { return }
            self.rabbit = .init(imageNamed: randomRabbit.textureName)
            self.rabbit.name = randomRabbit.name
            self.rabbit.position = randomRabbit.position
            self.rabbit.setScale(randomRabbit.scale)
            self.rabbit.zPosition = randomRabbit.zIndex
            self.addChild(self.rabbit)
            
            // Define a slide-up action
            let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: self.rabbit.size.height), duration: 1.0)
            slideUpAction.timingMode = .easeIn
            
            // Define a slide-down action
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -self.rabbit.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn
            
            // Define a sequence of actions
            let sequence = SKAction.sequence([
                slideUpAction,
                SKAction.wait(forDuration: 5.0),
                slideDownAction,
                SKAction.removeFromParent(),
                spawnCompletionAction
            ])
            
            self.rabbit.run(sequence)
            
            currentAnimalEntity = dataController.addAnimal(appearTime: Date(), animalTypeEnum: .rabbit, game: self.gameEntity, context: self.context)
            
        } else {
            // Spawn a fox
            guard let randomFox = foxPos.randomElement() else { return }
            self.fox = .init(imageNamed: randomFox.textureName)
            self.fox.name = randomFox.name
            self.fox.position = randomFox.position
            self.fox.setScale(randomFox.scale)
            self.fox.zPosition = randomFox.zIndex
            self.addChild(self.fox)
            
            let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: self.fox.size.height), duration: 1.0)
            slideUpAction.timingMode = .easeIn
            
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -self.fox.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn
            
            // Define a sequence of actions
            let sequence = SKAction.sequence([
                slideUpAction,
                SKAction.wait(forDuration: 5.0),
                slideDownAction,
                SKAction.removeFromParent(),
                spawnCompletionAction
            ])
            
            self.fox.run(sequence)
            currentAnimalEntity = dataController.addAnimal(appearTime: Date(), animalTypeEnum: .fox, game: self.gameEntity, context: self.context)
            
        }
    }
    
    func addRabbitPosition() {
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.1 , y: -size.height * 0.13),  scale: 1 * 0.826, zIndex: 6))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6 * 0.826, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.08), scale: 0.7 * 0.826, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.02), scale: 0.8 * 0.826, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.93 , y: -size.height * 0.08), scale: 1 * 0.826, zIndex: 5))
    }
    
    func addFoxPosition() {
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.08 , y: -size.height * 0.16 ), scale: 1 * 0.7, zIndex: 6))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.268 , y: size.height * 0.01 ), scale: 0.6 * 0.7, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.03  ), scale: 0.7 * 0.7, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.01), scale: 0.8 * 0.7, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.15 ), scale: 1 * 0.7, zIndex: 5))
    }
    
    func addNodes() {
        tutorialView = TutorialView(sceneFrame: frame)
        tutorialView.isUserInteractionEnabled = true
        tutorialView.delegate = self
        tutorialView.zPosition = 20
        addChild(tutorialView)
        
//        connection = .init(imageNamed: "noSignalIcon")
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
        
        pausedPopup = SKSpriteNode(imageNamed: "disconnectedPopUp")
        pausedPopup.setScale(0.5)
        pausedPopup.zPosition = 25
        pausedPopup.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(pausedPopup)
        
//        pausedLabel = SKLabelNode(fontNamed: "Jua-Regular")
//        pausedLabel.text = ""
//        pausedLabel.horizontalAlignmentMode = .center
//        pausedLabel.verticalAlignmentMode = .center
//        pausedLabel.numberOfLines = 2
//        pausedLabel.fontColor = .black
//        pausedLabel.fontSize = 21
//        pausedLabel.zPosition = 25
//        pausedLabel.preferredMaxLayoutWidth = pausedPopup.frame.width
//        
        
        pausedPopup.addChild(pausedLabel)
        
        disconnectPopup = SKSpriteNode(imageNamed: "disconnectedPopUp")
        disconnectPopup.setScale(1)
        disconnectPopup.zPosition = 26
        disconnectPopup.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(disconnectPopup)
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
        disconnectPopup.texture = updateIcon("disconnectedPopUp")
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
        dataController.editAvgAttentionReport(report: self.reportEntity, avgAttention: listFocusData.average(), context: self.context)
        //        dataController.fetchAndPrintFocusData()
        
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
        isCompleted = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if !isTouched && attentionPopup.isHidden {
                if rabbit.contains(location) {
                    // Change texture for the rabbit
                    rabbit.texture = SKTexture(imageNamed: "Rabbit_Tap")
                    rabbit.removeAllActions()
                    rabbitCount += 1
                    
                    // Update rabbitCount in GameData
                    GameData.rabbitCount = rabbitCount
                    
                    isTouched = true
                    
                    rabbit.run(slideSequence(y: rabbit.size.height))
                    dataController.editAnimalTapTime(animal: self.currentAnimalEntity, tapTime: Date(), context: self.context)
                }
                
                if fox.contains(location) {
                    // Change texture for the fox
                    fox.texture = SKTexture(imageNamed: "Fox_Tap")
                    fox.removeAllActions()
                    if rabbitCount - 1 <= 0 {
                        rabbitCount = 0
                    } else {
                        rabbitCount -= 1
                    }
                    
                    // Update rabbitCount in GameData
                    GameData.rabbitCount = rabbitCount
                    
                    isTouched = true
                    
                    fox.run(slideSequence(y: fox.size.height))
                    
                    dataController.editAnimalTapTime(animal: self.currentAnimalEntity, tapTime: Date(), context: self.context)
                }
            }
        }
    }
    
    func slideSequence(y: CGFloat) -> SKAction {
        let spawnCompletionAction = SKAction.run { [weak self] in
            self?.spawnNextEntity()
        }
        
        let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -y), duration: 1.0)
        slideDownAction.timingMode = .easeIn
        
        let sequence = SKAction.sequence([
            slideDownAction,
            SKAction.removeFromParent(),
            spawnCompletionAction
        ])
        
        return sequence
    }
    
    func startMWMPublisher() {
        
    }
    
    func stopMWMPublisher() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
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
        
        
        let minutes = timerValue / 60
        let seconds = timerValue % 60
        
        focusBar.updateProgressBar(CGFloat(self.focusCount), timeLeft: String(format:"%d:%02d", minutes, seconds), score: rabbitCount)
        attentionPopup.update(currentTime)
        if tutorialView.isHidden {
            if self.focusCount < 50  {
                self.fox.isPaused = true
                self.rabbit.isPaused = true
                if !attentionPopup.isShowing {
                    attentionPopup.isHidden = false
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
            
            else {
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
