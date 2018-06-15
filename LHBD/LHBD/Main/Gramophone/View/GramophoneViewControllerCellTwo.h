//
//  GramophoneViewControllerCellTwo.h
//  BasicFramework
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioModel.h"

@class GramophoneViewControllerCellTwo;
@protocol  GramophoneViewControllerCellTwoDelegate <NSObject>
@optional
- (void)removeGramophoneViewControllerCellTwo:(GramophoneViewControllerCellTwo *)gramophoneViewControllerCellTwo;
@required
@end
@interface GramophoneViewControllerCellTwo : UICollectionViewCell
- (void)startAnimation;
@property (nonatomic,strong) AudioModel *audioModel;
@property (nonatomic,assign,getter=isStop) BOOL stop;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign,getter=isAction) BOOL  action;
@property (nonatomic,weak) id<GramophoneViewControllerCellTwoDelegate> delegate;
@end
