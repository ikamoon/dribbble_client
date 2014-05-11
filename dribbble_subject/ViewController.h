//
//  ViewController.h
//  dribbble_subject
//
//  Created by ikamon on 2014/04/16.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionView.h"

@interface ViewController : UIViewController <PSCollectionViewDataSource, PSCollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic,retain) PSCollectionView *collectionView;

@end
