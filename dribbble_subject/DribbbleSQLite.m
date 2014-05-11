//
//  DribbbleSQLite.m
//  dribbble_subject
//
//  Created by ikamon on 2014/04/20.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import <sqlite3.h>
#import "DribbbleSQLite.h"
#import "DribbbleRecords.h"

@implementation DribbbleSQLite {
    NSString*   _databaseFilePath;      //  SQLiteのファイルパス。
}

static DribbbleSQLite* _SQLite;
+ (DribbbleSQLite*)sharedSQLite
{
    //  共有するMBSQLiteをアプリケーション中に1つだけ作成。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

    });
    return _SQLite;
}

@end
