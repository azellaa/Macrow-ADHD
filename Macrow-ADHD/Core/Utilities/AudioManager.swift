//
//  AudioManager.swift
//  Macrow-ADHD
//
//  Created by Gregorius Yuristama Nugraha on 11/2/23.
//


import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private var backgroundMusicPlayer: AVAudioPlayer?
    var soundEffectPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playBackgroundMusic(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Background music file not found.")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        } catch {
            print("Failed to play background music: \(error.localizedDescription)")
        }
    }
    
    func playSoundEffect(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "wav") else {
            print("Sound effect file not found.")
            return
        }
        
        do {
            soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
            soundEffectPlayer?.prepareToPlay()
            soundEffectPlayer?.play()
            
        } catch {
            print("Failed to play sound effect: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        backgroundMusicPlayer = nil
    }
    
    func stopSoundEffect() {
        soundEffectPlayer?.stop()
        soundEffectPlayer = nil
    }
    

}

