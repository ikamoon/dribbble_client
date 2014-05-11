//
//  EveryoneModel.h
//  dribbble_subject
//
//  Created by ikamon on 2014/04/20.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingDalegate.h"

@interface DribbbleCoreData : NSObject <NetworkingDalegate>

- (instancetype)init;

- (void)getShots:(NSString *)page reciever:(id)reciever;

+ (DribbbleCoreData *)sharedCoreData;
- (NSManagedObjectContext *)managedObjectContext;

@end
