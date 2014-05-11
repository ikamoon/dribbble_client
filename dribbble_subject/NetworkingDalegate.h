//
//  NetworkingDalegate.h
//  dribbble_subject
//
//  Created by ikamon on 2014/04/20.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NetworkingDalegate <NSObject>

@optional

- (void)recieveEveryone:(NSDictionary *)dictionary;

@end