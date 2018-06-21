//
//  Audio+CoreDataProperties.h
//  
//
//  Created by 周鑫 on 2018/6/20.
//
//

#import "Audio+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Audio (CoreDataProperties)

+ (NSFetchRequest<Audio *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *path;
@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *password;

@end

NS_ASSUME_NONNULL_END
