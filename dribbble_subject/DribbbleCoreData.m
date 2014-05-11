//
//  DribbbleCoreData.m
//  dribbble_subject
//
//  Created by ikamon on 2014/04/20.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "DribbbleCoreData.h"
#import "DribbbleSQLite.h"
#import "AFNetworking/AFNetworking.h"


#define DRIBBBLE_PATH @"http://api.dribbble.com/shots/"

@implementation DribbbleCoreData {
    NSManagedObjectContext *_managedObjectContext;
}

static DribbbleCoreData* _CoreData;
+ (DribbbleCoreData*)sharedCoreData;
{
    //  共有するMBCoreDataをアプリケーション中に1つだけ作成。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _CoreData = [[DribbbleCoreData alloc] init];
    });
    return _CoreData;
}

+ (NSURL*)url
{
    static NSURL* storeURL = nil;
    if (storeURL) {
        return storeURL;
    }
    storeURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    storeURL = [storeURL URLByAppendingPathComponent:@"DribbbleCoreData.sqlite"];
    return storeURL;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    //  Core Dataモデルファイルディレクトリの指定
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel* managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    //  自分のクラスオブジェクトからURLをもらうように変更。　[self class].url
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self class].url options:nil error:&error]) {
        NSLog(@"永続ストアの設定に失敗 %@", [error localizedDescription]);
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"永続ストアへの保存に失敗 %@", [error localizedDescription]);
        }
    }
}
- (void)convert
{
    DribbbleSQLite* sq = [DribbbleSQLite sharedSQLite];
    
    [self saveContext];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)getShots:(NSString *)page reciever:(id)reciever
{
    NSString *item_url = [NSString stringWithFormat:@"%@/everyone", DRIBBBLE_PATH];
    NSDictionary *params = @{@"page": page};

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    
    [manager GET:item_url
      parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil] ;
             
             [reciever recieveEveryone:dictionary];
             NSLog(@"responseObject: %@", dictionary);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // エラーの場合はエラーの内容をコンソールに出力する
             NSLog(@"Error: %@", error);
         }];
}

@end
