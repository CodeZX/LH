//
//  Audio+CoreDataProperties.m
//  
//
//  Created by 周鑫 on 2018/6/20.
//
//

#import "Audio+CoreDataProperties.h"

@implementation Audio (CoreDataProperties)

+ (NSFetchRequest<Audio *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Audio"];
}

@dynamic name;
@dynamic path;
@dynamic date;
@dynamic password;

@end
