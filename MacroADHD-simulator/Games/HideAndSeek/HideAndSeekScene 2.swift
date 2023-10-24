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
    private var rabbitCounter = SKSpriteNode()
    private var connection = SKSpriteNode()
    private var focusBar = ProgressBar()
    private var bg = BackgroundHideAndSeek()
    private var rabbitPos = [NodeElement]()
    private var foxPos = [NodeElement]()
    private var tutorialView = TutorialView()
    private let rabbitCountLabel = SKLabelNode(text: "x0")
    
    private var rabbitCount = 0
    private var isTouched = false
    private var isTutorialOpened = true
    private var timerValue: Int = 600 // timer 10 menit
    
    public var focusCount = 80 // focus point
    public var isSpawning = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var listFocusData: [Double] = [Double]()
    
//    var mwmObject = MWMInstance.shared
    
    public var isCompleted = false
    private var attentionPopup = AttentionPopup()
    private var headpieceStatus = HeadpieceIndicator()
    private var signalStatus: Int = 4
    var dataController: DataController!
    var context: NSManagedObjectContext!
    
    var gameEntity: Game!
    
    var reportEntity: Report!
    
    var pauseDataEntity: Pause!
    
    var currentAnimalEntity: Animal!
    
    var isSavingPauseData = false
    var isPublisherStarted = false
    var firstAnimalSpawned = false
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        dataController = DataController()
        self.context = dataController.container.viewContext
        
        self.gameEntity = dataController.addGame(gameName: "Hide And Seek", level: 1, context: self.context)
        
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
            if !self.isTutorialOpened && self.signalStatus == 4{
                self.timerValue -= 1
            }
        }
        
        
    }
    
    
    
//    private func handleMWMData(_ mwmData: MWMData) {
//        // Update your UI or perform other actions with the received data
//        print("Received MWMData: (Signal, Att, Med) \(mwmData.poorSignal), \(mwmData.attention), \(mwmData.meditation)")
//        focusCount = Int(mwmData.attention)
//        
//        if signalStatus == 4 && !isCompleted{
//            dataController.addFocus(value: Int16(self.focusCount), time: Date(), report: self.reportEntity, context: self.context)
//            listFocusData.append(Double(focusCount))
//        }
//    }
    
    func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool) {
        self.isTutorialOpened = isTutorialOpened
    }
    
    
    func spawnNextEntity() {
        isSpawning = false
        isTouched = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.spawnEntity()
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
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.1 , y: -size.height * 0.1), scale: 1, zIndex: 6))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.11), scale: 0.7, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.04), scale: 0.8, zIndex: 3))
        rabbitPos.append(NodeElement(name: "rabbit", textureName: "Rabbit_Hide", position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.04), scale: 1, zIndex: 5))
    }
    
    func addFoxPosition() {
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.1 , y: -size.height * 0.13), scale: 1, zIndex: 6))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.28 , y: size.height * 0.06), scale: 0.6, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.42 , y: size.height * 0.11), scale: 0.7, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.65 , y: size.height * 0.03), scale: 0.8, zIndex: 3))
        foxPos.append(NodeElement(name: "fox", textureName: "Fox_Seek", position: CGPoint(x: size.width * 0.92 , y: -size.height * 0.06), scale: 1, zIndex: 5))
    }
    
    func addNodes() {
        rabbitCountLabel.fontName = "AvenirNext-Bold"
        rabbitCountLabel.fontSize = 30
        rabbitCountLabel.name = "rabbitCountLabel"
        rabbitCountLabel.position = CGPoint(x: frame.width * 0.835, y: frame.height * 0.873)
        rabbitCountLabel.zPosition = 15
        addChild(rabbitCountLabel)
        
        tutorialView = TutorialView(sceneFrame: frame)
        tutorialView.isUserInteractionEnabled = true
        tutorialView.delegate = self
        tutorialView.zPosition = 20
        addChild(tutorialView)
        
        rabbitCounter = .init(imageNamed: "RabbitCounter")
        //        rabbitCounter.setScale(0.9)
        //        rabbitCounter.size.width = rabbitCounter.size.width * 1.05
        rabbitCounter.position = CGPoint(x: frame.width * 0.815, y: frame.height * 0.89)
        rabbitCounter.zPosition = 10
        addChild(rabbitCounter)
        
        connection = .init(imageNamed: "nosignal")
        connection.position = CGPoint(x: frame.width * 0.930, y: frame.height * 0.89)
        connection.size = CGSize(width: 83, height: 79)
        connection.zPosition = 10
        addChild(connection)
        
        focusBar.getSceneFrame(sceneFrame: frame)
        focusBar.setScale(0.9)
        focusBar.buildProgressBar()
        focusBar.position = CGPoint(x: frame.width * 0.47 , y: frame.height * 0.89)
        addChild(focusBar)
        
        
        attentionPopup = AttentionPopup(sceneFrame: frame)
        attentionPopup.isShowing = false
        attentionPopup.isHidden = true
        attentionPopup.zPosition = 20
        addChild(attentionPopup)
        
        headpieceStatus.getSceneFrame(sceneFrame: frame)
        headpieceStatus.buildIndicator()
        addChild(headpieceStatus)
        
    }
    
    func updateRabbitCountLabel() {
        rabbitCountLabel.text = "x\(rabbitCount)"
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
        dataController.fetchAndPrintFocusData()
        
        run(SKAction.sequence([
            SKAction.run { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.fade(withDuration: 0.5)
                
                let scene = GameOverPage()
                view?.presentScene(scene, transition: reveal)
            }
        ]))
        
        isCompleted = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if !isTouched {
                if rabbit.contains(location) {
                    // Change texture for the rabbit
                    rabbit.texture = SKTexture(imageNamed: "Rabbit_Tap")
                    rabbit.removeAllActions()
                    rabbitCount += 1
                    
                    // Update rabbitCount in GameData
                    GameData.rabbitCount = rabbitCount
                    
                    updateRabbitCountLabel()
                    isTouched = true
                    
                    rabbit.run(slideSequence(y: rabbit.size.height))
                    dataController.editAnimalTapTime(animal: self.currentAnimalEntity, tapTime: Date(), context: self.context)
                }
                
                if fox.contains(location) {
                    // Change texture for the fox
                    fox.texture = SKTexture(imageNamed: "Fox_Tap")
                    fox.removeAllActions()
                    rabbitCount -= 1
                    
                    // Update rabbitCount in GameData
                    GameData.rabbitCount = rabbitCount
                    
                    updateRabbitCountLabel()
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
    
    fileprivate func startMWMPublisher() {
//        mwmObject.mwmDataPublisher
//            .sink { [weak self] mwmData in
//                // Handle the emitted MWMData here
//                self?.handleMWMData(mwmData)
//                
//            }
//            .store(in: &cancellables)
//        mwmObject.signalStatusPublisher
//            .sink { signalStatus in
//                self.signalStatus = signalStatus
//                print("Signal: \(self.signalStatus)")
//            }
//            .store(in: &cancellables)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateRabbitCountLabel()
        openTutorial()
        
        if !isTutorialOpened {
            if !isPublisherStarted {
                startMWMPublisher()
                isPublisherStarted = true
            }
            
            if !firstAnimalSpawned {
                spawnEntity()
                firstAnimalSpawned = true
            }
        }
        
        focusBar.updateProgressBar(CGFloat(self.focusCount))
        attentionPopup.update(currentTime)
        if tutorialView.isHidden {
            if self.focusCount < 50  {
                self.fox.isPaused = true
                self.rabbit.isPaused = true
                if !attentionPopup.isShowing {
                    attentionPopup.isHidden = false
                    attentionPopup.startShowPause()
                    if !isSavingPauseData {
                        pauseDataEntity = dataController.addPause(startTime: Date(), report: self.reportEntity, context: self.context)
                        isSavingPauseData = true
                    }
                    
                    
                }
            } else if self.signalStatus != 4 {
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