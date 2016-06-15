//
//  CommonSqliteUtil.h
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/28/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface HongSqlite : NSObject

+ (void)setDataBaseName:(NSString *)name;
+ (BOOL)create:(NSString *)sql;
+ (BOOL)insert:(NSString *)sql values:(NSArray *)values;
+ (BOOL)remove:(NSString *)sql values:(NSArray *)values;
+ (BOOL)update:(NSString *)sql values:(NSArray *)values;
//+ (NSMutableArray *)query:(NSString *)sql values:(NSArray *)values;
+ (NSMutableArray *)query:(NSString *)sql values:(NSArray *)values block:(id (^)(sqlite3_stmt * stmt))block;
+ (NSMutableArray *)query:(NSString *)sql values:(NSArray *)values funPoint:(id(*)(sqlite3_stmt *stmt))funPoint;


+ (NSString *)getTextFromStmt:(sqlite3_stmt *)stmt atIndex:(int)index;

@end
