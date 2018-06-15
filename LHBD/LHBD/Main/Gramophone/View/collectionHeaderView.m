//
//  collectionHeaderView.m
//  BasicFramework
//
//  Created by 金圣官 on 2018/6/7.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "collectionHeaderView.h"

@interface collectionHeaderView  ()


@end
@implementation collectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
//    self.backgroundColor = ClearColor;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"今天";
//    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    self.label = label;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.centerY.equalTo(self);
    }];

    
    
    
}

@end
