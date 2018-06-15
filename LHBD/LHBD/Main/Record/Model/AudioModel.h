//
//  AvdioModel.h
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioModel : NSObject <NSCoding>
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *path;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *password;
- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path Date:(NSString *)date Password:(NSString *)password;
- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path Password:(NSString *)password;
- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path;
@end
