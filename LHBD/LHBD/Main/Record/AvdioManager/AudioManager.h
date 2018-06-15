//
//  AvdioManager.h
//  BasicFramework
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const KeyAudioAry;
extern NSString * const KeyPassWordAudioAry;

@interface AudioManager : NSObject
@property (nonatomic,strong) YYCache *audioCache;
WMSingletonH(AudioManager)
@end
