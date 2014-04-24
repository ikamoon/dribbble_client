//
//  Debug.h
//  NewsReader
//
//  Created by lanway_mac on 2013/08/15.
//  Copyright (c) 2013年 lanway_mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define DEBUG_LOG(...)    NSLog(@"DEBUG: "__VA_ARGS__)


#else

#define DEBUG_LOG(...) ;

#endif

@protocol Debug <NSObject>

@end
