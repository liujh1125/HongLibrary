//
//  CommonFMDBUtil.m
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/25/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "HongFMDB.h"
//#import <FMDB/FMDB.h>
#import "FMDatabase.h"



@implementation HongFMDB

//#define kDBName @"demo.sqlite3"
static NSString *dbName_fmdb = @"";


+ (void)setDataBaseName:(NSString *)name{
    [self setDataBaseName:name copy:YES];
}

+ (void)setDataBaseName:(NSString *)name copy:(BOOL)isCopy
{
    NSAssert(name, @"name cannot be nil!");
    
    dbName_fmdb = name;
    
    if (isCopy) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self dbPath]]) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:dbName_fmdb ofType:nil];//注意如果bundlePath == nil,那请检查Build Phases下的Copy Bundle Resources中是不是没有添加该资源
            if ([[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
                [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:[self dbPath] error:nil];
            }
            else {
                NSAssert(NO, @"%@ does not exist!", dbName_fmdb);
            }
        }
    }
}



#pragma mark - create

+ (BOOL)create:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self executeUpdate:sql args:nil];
}


#pragma mark - insert

+ (BOOL)insert:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self executeUpdate:sql args:nil];
}

#pragma mark - remove

+ (BOOL)remove:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self executeUpdate:sql args:nil];
}

#pragma mark - update

+ (BOOL)update:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self executeUpdate:sql args:nil];
}



#pragma mark - query

+ (NSMutableArray *)query:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            [result addObject:[rs resultDictionary]];
        }
        
        [db close];
    }
    
    db = nil;
    
    return result;
}



#pragma mark - private method

+ (BOOL)executeUpdate:(NSString *)sql args:(NSArray *)args
{
    BOOL success = NO;
    
    FMDatabase *db = [FMDatabase databaseWithPath:[self dbPath]];
    
    if ([db open]) {
        success = [db executeUpdate:sql withArgumentsInArray:args];
        
        [db close];
    }
    
    db = nil;
    
    return success;
}

+ (NSString *)dbPath
{
    NSAssert(dbName_fmdb, @"dbName cannot be nil!");
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:dbName_fmdb];
    
//    NSLog(@"数据库存放路径dbPath = %@",dbPath);
    if (![fm fileExistsAtPath:dbPath]) {
        [fm createFileAtPath:dbPath contents:nil attributes:nil]; //开始创建文件
    }
    
    return dbPath;
}




@end
