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
    
    public var focusCount = 0 // focus point
    public var isSpawning = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    var mwmObject = MWMInstance.shared
    
    private var listFocusData: [Double] = [Double]()
    
    
    public var isCompleted = false
    private var attentionPopup = AttentionPopup()
    private var headpieceStatus = HeadpieceIndicator()
    private var signalStatus: Int = 4
    var dataController: DataController!
    var context: NSManagedObjectContext!
    
    
    override func didMove(to view: SKView) {
        
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
        spawnEntity()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timerValue <= 1 {
                timer.invalidate()
                self.timesUpFunc()
            }
            if !self.isTutorialOpened {
                self.timerValue -= 1
            }
        }
        
        mwmObject.mwmDataPublisher
            .sink { [weak self] mwmData in
                // Handle the emitted MWMData here
                self?.handleMWMData(mwmData)
                
            }
            .store(in: &cancellables)
        mwmObject.signalStatusPublisher
            .sink { signalStatus in
                self.signalStatus = signalStatus
                print("Signal: \(self.signalStatus)")
            }
            .store(in: &cancellables)
    }
    
    func tutorialIsOpen(_ tutorialView: TutorialView, isTutorialOpened: Bool) {
        self.isTutorialOpened = isTutorialOpened
    }
    
    private func handleMWMData(_ mwmData: MWMData) {
        // Update your UI or perform other actions with the received data
        print("Received MWMData: (Signal, Att, Med) \(mwmData.poorSignal), \(mwmData.attention), \(mwmData.meditation)")
        focusCount = Int(mwmData.attention)
        if !isCompleted {
            listFocusData.append(Double(focusCount))
        }
        // Example: Update a UILabel
        // self.yourLabel.text = "Poor Signal: \(mwmData.poorSignal), Attention: \(mwmData.attention), Meditation: \(mwmData.meditation)"
    }
    
    func spawnNextEntity() {
        isSpawning = false
        isTouched.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
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
            rabbit = .init(imageNamed: randomRabbit.textureName)
            rabbit.name = randomRabbit.name
            rabbit.position = randomRabbit.position
            rabbit.setScale(randomRabbit.scale)
            rabbit.zPosition = randomRabbit.zIndex
            addChild(rabbit)
            
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
                spawnCompletionAction
            ])


            rabbit.run(sequence)
            
        } else {
            // Spawn a fox
            guard let randomFox = foxPos.randomElement() else { return }
            fox = .init(imageNamed: randomFox.textureName)
            fox.name = randomFox.name
            fox.position = randomFox.position
            fox.setScale(randomFox.scale)
            fox.zPosition = randomFox.zIndex
            addChild(fox)
            
            let slideUpAction = SKAction.move(by: CGVector(dx: 0, dy: fox.size.height), duration: 1.0)
            slideUpAction.timingMode = .easeIn
            
            let slideDownAction = SKAction.move(by: CGVector(dx: 0, dy: -fox.size.height), duration: 1.0)
            slideDownAction.timingMode = .easeIn

            // Define a sequence of actions
            let sequence = SKAction.sequence([
                slideUpAction,
                SKAction.wait(forDuration: 5.0),
                slideDownAction,
                SKAction.removeFromParent(),
                spawnCompletionAction
            ])

            fox.run(sequence)
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
        
        focusBar.getSceneFrame(sceneFrame: frame)
        focusBar.setScale(0.9)
        focusBar.buildProgressBar()
        focusBar.position = CGPoint(x: frame.width * 0.47 , y: frame.height * 0.89)
        addChild(focusBar)
        
        
        attentionPopup = AttentionPopup(sceneFrame: frame)
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
        } else {
            tutorialView.isHidden = false
            self.fox.isPaused = true
            self.rabbit.isPaused = true
        }
    }
    
    func timesUpFunc() {
//        dataController.fetchAndPrintFocusData() // Fetch and print the data when the timer ends
        
        run(SKAction.sequence([
            SKAction.run { [weak self] in
                guard let `self` = self else { return }
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                
                let scene = NewPage()
                view?.presentScene(scene, transition: reveal)
            }
        ]))
        
        isCompleted = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Initialize the data controller and obtain the managed object context
        dataController = DataController()
        let context = DataController().container.viewContext
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if !isTouched {
                if rabbit.contains(location) {
                    // Change texture for the rabbit
                    rabbit.texture = SKTexture(imageNamed: "Rabbit_Tap")
                    rabbit.removeAllActions()
                    rabbitCount += 1
                    
                    // Save the updated rabbit count to Core Data
                    dataController.addFocus(value: Double(rabbitCount), gameID: 1, context: context)

                    updateRabbitCountLabel()
                    isTouched.toggle()
                    
                    rabbit.run(slideSequence(y: rabbit.size.height))
                }
                
                if fox.contains(location) {
                    // Change texture for the fox
                    fox.texture = SKTexture(imageNamed: "Fox_Tap")
                    fox.removeAllActions()
                    rabbitCount -= 1
                    updateRabbitCountLabel()
                    isTouched.toggle()
                    
                    fox.run(slideSequence(y: fox.size.height))
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
    
    override func update(_ currentTime: TimeInterval) {
        updateRabbitCountLabel()
        openTutorial()
        
        focusBar.updateProgressBar(CGFloat(self.focusCount))
        if tutorialView.isHidden {
            if self.focusCount < 50  {
                self.fox.isPaused = true
                self.rabbit.isPaused = true
                attentionPopup.isHidden = false
                if CACurrentMediaTime() - attentionPopup.lastMove > attentionPopup.moveRate {
                    attentionPopup.update(currentTime)
                    
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
            }
        }
    }
}
