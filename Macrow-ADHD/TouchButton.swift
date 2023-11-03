//
//  TouchimageButton.swift
//  MacroADHD-simulator
//
//  Created by Azella Mutyara on 30/10/23.
//

import SwiftUI

struct TouchButton: View {
    @State private var isTouched = false
    @Binding var padding: CGFloat
    
    var normalImageName: String
    var pressedImageName: String
    var action: () -> Void

    var body: some View {
        UIKitButton(isTouched: $isTouched, padding: $padding, normalImageName: normalImageName, pressedImageName: pressedImageName, action: action)
    }
}

struct UIKitButton: UIViewRepresentable {
    @Binding var isTouched: Bool
    @Binding var padding: CGFloat
    var normalImageName: String
    var pressedImageName: String
    var action: () -> Void

    
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: normalImageName), for: .normal)
        button.setImage(UIImage(named: pressedImageName), for: .highlighted)
        
        // Set content hugging and compression resistance priorities to high
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTouched), for: .touchDown)
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonReleased), for: .touchUpInside)
        
        return button
    }


    func updateUIView(_ uiView: UIButton, context: Context) {
        // Update the image if needed
        uiView.setImage(UIImage(named: isTouched ? pressedImageName : normalImageName), for: .normal)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: UIKitButton

        init(_ parent: UIKitButton) {
            self.parent = parent
        }

        @objc func buttonTouched() {
            parent.isTouched = true
            parent.padding = 0
//            parent.action()
        }

        @objc func buttonReleased() {
            parent.isTouched = false
            parent.padding = 5
            parent.action()
        }
    }
}

struct TouchButton_Previews: PreviewProvider {
    static var previews: some View {
        TouchButton(padding: .constant(0), normalImageName: "PlayButtonNotPressed", pressedImageName: "PlayButtonPressed", action: {
            print("Button Pressed")
        })
    }
}
