//
//  UIView+HUD.h
//  WangYe
//
//  Created by Mars on 2017/2/7.
//  Copyright © 2017年 YG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
- (void)showHUD;

- (void)hideHUD;

- (void)showMessage:(NSString *)message;
@end
