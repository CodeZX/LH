//
//  AvdioManager.m
//  BasicFramework
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "AudioManager.h"

NSString * const KeyAudioAry = @"audioAry";
NSString * const KeyPassWordAudioAry = @"passWordAudioAry";



static NSString * const audioCacheName = @"audioc";

@implementation AudioManager
WMSingletonM(AudioManager)
- (YYCache *)audioCache {
    if (!_audioCache) {
        _audioCache = [[YYCache alloc]initWithName:audioCacheName];
    }
    return  _audioCache;
}
@end
