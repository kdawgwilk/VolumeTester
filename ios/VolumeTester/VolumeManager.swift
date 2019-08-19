//
//  VolumeManager.swift
//  VolumeTester
//
//  Created by Kaden Wilkinson on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import MediaPlayer

@objc(VolumeManager)
class VolumeManager: NSObject, RCTBridgeModule {
  static func moduleName() -> String! {
    return "VolumeManager"
  }
  
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  @objc
  func currentVolume(_ callback: @escaping RCTResponseSenderBlock) {
    DispatchQueue.main.async {
      callback([AVAudioSession.sharedInstance().outputVolume])
    }
  }
  
  @objc
  func incrementVolume(_ resolve: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let slider = self.slider else {
        print("No Slider")
        return
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
        slider.increment()
        resolve(slider.value)
      }
    }
  }
  
  @objc
  func decrementVolume(_ resolve: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      guard let slider = self.slider else {
        print("No Slider")
        return
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
        slider.increment()
        resolve(slider.value)
      }
    }
  }
  
  
  
  
  
  
  
  
  let volumeView = MPVolumeView()
  lazy var slider: UISlider? = {
    let s = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
    s?.value = AVAudioSession.sharedInstance().outputVolume
    return s
  }()
  
  override init() {
    super.init()
    
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
      while let presentedViewController = topController.presentedViewController {
        topController = presentedViewController
      }
      topController.view.addSubview(volumeView)
    }
  }
}

extension UISlider {
  func increment() {
    if value > 0.99 {
      value += 0.1
    } else {
      value = 1.0
    }
  }
  
  func decrement() {
    if value > 0.01 {
      value -= 0.1
    } else {
      value = 0.0
    }
  }
}
