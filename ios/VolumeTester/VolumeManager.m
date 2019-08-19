//
//  VolumeManager.m
//  VolumeTester
//
//  Created by Kaden Wilkinson on 8/19/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(VolumeManager, NSObject)

RCT_EXTERN_METHOD(currentVolume:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(incrementVolume:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(decrementVolume:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end
