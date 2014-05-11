//
//  DribbbleSQLite.h
//  dribbble_subject
//
//  Created by ikamon on 2014/04/20.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DribbbleSQLite : NSObject

//  共有するMBSQLiteを戻す。
+ (DribbbleSQLite*)sharedSQLite;

@end
