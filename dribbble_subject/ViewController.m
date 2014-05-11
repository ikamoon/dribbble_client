//
//  ViewController.m
//  dribbble_subject
//
//  Created by ikamon on 2014/04/16.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DribbbleCoreData.h"
#import <CoreData/CoreData.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "DetailViewController.h"

@interface ViewController () <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *_fetchedResuktController;
    NSMutableArray             *shotsData;
    BOOL                        isLoading;
    NSInteger                   pageNum;
}

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    pageNum = 1;
    
    // Dribbble から取得
    isLoading = YES;
    shotsData = [[NSMutableArray alloc] initWithArray:@[]];
    DribbbleCoreData *everyone = [[DribbbleCoreData alloc] init];
    [everyone getShots:[NSString stringWithFormat:@"%ld", (long)pageNum] reciever:self];
    
    //collectionView生成
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.collectionView];
    
    //collectionViewの各種設定
    self.collectionView.delegate = self;
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //表示する列数
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma getEveryone reciever

- (void)recieveEveryone:(NSDictionary *)dictionary
{
    NSArray *rec_dic = [dictionary objectForKey:@"shots"];
    if (shotsData.count == 0) {
        shotsData = [NSMutableArray arrayWithArray:rec_dic];
    } else {
        [shotsData addObjectsFromArray:rec_dic];
    }
    
    [self.collectionView reloadData];
    isLoading = NO;
}

#pragma PSCollectionView DataSource & Delegate


//表示するセルの数
- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return shotsData.count;
}

//セルの高さ
- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return [CollectionViewCell rowHeightForObject:[shotsData objectAtIndex:index]];
}

//セルの描画処理
- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    NSDictionary *shot = [shotsData objectAtIndex:index];
    
    CollectionViewCell *cell = (CollectionViewCell *)[self.collectionView dequeueReusableViewForClass:[CollectionViewCell class]];
    
    CGFloat height = [CollectionViewCell rowHeightForObject:shot];
    cell = [[CollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2 - 10, height)];
    
    [cell collectionView:collectionView fillCellWithObject:shot atIndex:index];
    
    return cell;
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    [self.navigationController pushViewController:[[DetailViewController alloc] initWithShotData:[shotsData objectAtIndex:index]]  animated:YES];
}


#pragma UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 最後までスクロールされたら、さらに読み込む
    if (!isLoading && self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
        pageNum++;
        DribbbleCoreData *everyone_model = [[DribbbleCoreData alloc] init];
        [everyone_model getShots:[NSString stringWithFormat:@"%ld", (long)pageNum] reciever:self];
        isLoading = YES;
    }
}


@end
