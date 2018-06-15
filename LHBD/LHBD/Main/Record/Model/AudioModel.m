//
//  AvdioModel.m
//  BasicFramework
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 Rainy. All rights reserved.
//

#import "AudioModel.h"


@interface AudioModel ()

@end
@implementation AudioModel
- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path Date:(NSString *)date Password:(NSString *)password {
    
    self = [super init];
    if (self) {
        self.title = title;
        self.path = path;
        self.date = date;
        self.password = password;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path {
    
   return  [self initWithTitle:title Path:path Date:nil Password:nil];
}

- (instancetype)initWithTitle:(NSString *)title Path:(NSString *)path Password:(NSString *)password {
    
    return [self initWithTitle:title Path:path Date:nil Password:password];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.title = [coder decodeObjectForKey:@"title"];
        self.path = [coder decodeObjectForKey:@"path"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.password = [coder decodeObjectForKey:@"password"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.path forKey:@"path"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.password forKey:@"password"];
}


@end
