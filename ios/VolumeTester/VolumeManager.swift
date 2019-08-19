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
      let newValue: Float
      if slider.value < 0.99 {
        newValue = slider.value + 0.1
      } else {
        newValue = 1.0
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
        slider.value = newValue
        resolve(newValue)
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
      let newValue: Float
      if slider.value > 0.01 {
        newValue = slider.value - 0.1
      } else {
        newValue = 0.0
      }
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
        slider.value = newValue
        resolve(newValue)
      }
    }
  }
}
