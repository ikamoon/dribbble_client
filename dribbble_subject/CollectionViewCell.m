//
//  CollectionViewCell.m
//  dribbble_subject
//
//  Created by ikamon on 2014/04/19.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import "CollectionViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation CollectionViewCell {
    UIImageView *imageView;
    UIView      *bandView;
    UILabel     *titleLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.clipsToBounds = YES;
        
        bandView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
        bandView.layer.opacity = 0.3;
        bandView.layer.backgroundColor = [UIColor blackColor].CGColor;
        
        titleLabel = [[UILabel alloc] initWithFrame:bandView.frame];
        titleLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:imageView];
        [self addSubview:bandView];
        [self addSubview:titleLabel];
        
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    imageView  = nil;
    bandView   = nil;
    titleLabel = nil;
}

- (void)collectionView:(PSCollectionView *)collectionView fillCellWithObject:(id)object atIndex:(NSInteger)index
{
    [super collectionView:collectionView fillCellWithObject:object atIndex:index];
    
    //オブジェクトから値を取り出す
    NSURL *url = [NSURL URLWithString:(NSString *)[object objectForKey:@"image_teaser_url"]];
    [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.alpha = 0;
        [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            imageView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }];
//                  setImageWithURL:[NSURL URLWithString:(NSString *)[object objectForKey:@"image_teaser_url"]]];
    titleLabel.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"title"]];
}

//セルの高さ設定
+ (CGFloat)rowHeightForObject:(id)object
{
    //オブジェクトから高さを取り出し、セルの高さを返す
    CGFloat image_height = [NSString stringWithFormat:@"%@", [object objectForKey:@"height"]].floatValue;
    CGFloat image_width  = [NSString stringWithFormat:@"%@", [object objectForKey:@"width"]].floatValue;
    CGFloat height = 150 * (image_height / image_width);
    
    return height;
}

@end
