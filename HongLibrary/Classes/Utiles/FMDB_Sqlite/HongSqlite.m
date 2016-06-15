//
//  CommonSqliteUtil.m
//  CommonFMDBUtilDemo
//
//  Created by lichq on 6/28/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "HongSqlite.h"

@implementation HongSqlite

//#define kDBName @"demo.sqlite3"
static NSString *dbName_sqlite = @"";

+ (void)setDataBaseName:(NSString *)name{
    [self setDataBaseName:name copy:YES];
}

+ (void)setDataBaseName:(NSString *)name copy:(BOOL)isCopy
{
    NSAssert(name, @"name cannot be nil!");
    
    dbName_sqlite = name;
    
    if (isCopy) {
        if(![[NSFileManager defaultManager] fileExistsAtPath:[self dbPath]]) {
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:dbName_sqlite ofType:nil];//注意如果bundlePath == nil,那请检查Build Phases下的Copy Bundle Resources中是不是没有添加该资源
            if ([[NSFileManager defaultManager] fileExistsAtPath:bundlePath]) {
                [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:[self dbPath] error:nil];
            }
            else {
                NSAssert(NO, @"%@ does not exist!", dbName_sqlite);
            }
        }
    }
}


#pragma mark - create

+ (BOOL)create:(NSString *)sql
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self exec:sql];
}


#pragma mark - insert

+ (BOOL)insert:(NSString *)sql values:(NSArray *)values
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self prepare_step:sql values:values];
}

#pragma mark - remove

+ (BOOL)remove:(NSString *)sql values:(NSArray *)values
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self prepare_step:sql values:values];
}

#pragma mark - update

+ (BOOL)update:(NSString *)sql values:(NSArray *)values
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self prepare_step:sql values:values];
}



#pragma mark - query
+ (NSMutableArray *)query:(NSString *)sql values:(NSArray *)values block:(id (^)(sqlite3_stmt * stmt))block
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self prepare_step_select:sql values:values block:block funPoint:nil];
}

+ (NSMutableArray *)query:(NSString *)sql values:(NSArray *)values funPoint:(id(*)(sqlite3_stmt *stmt))funPoint
{
    NSAssert(sql, @"sql cannot be nil!");
    
    return [self prepare_step_select:sql values:values block:nil funPoint:funPoint];
}



#pragma mark - private method

+ (BOOL)exec:(NSString *)sql
{
    BOOL success = NO;
    
    sqlite3 *db = [self databaseWithPath:[self dbPath]];
    
    if (nil != db) {
        char *errorMsg;
        
        success = sqlite3_exec (db, [sql UTF8String], NULL, NULL, &errorMsg);
        
        if (success != SQLITE_OK) {
            sqlite3_close(db);
            NSLog(@"Error creating table:%@ %s", sql, errorMsg);
        }
        sqlite3_free(errorMsg);
    }
    
    db = nil;
    
    return success;
}


+ (BOOL)prepare_step:(NSString *)sql values:(NSArray *)values
{
    sqlite3 *db = [self databaseWithPath:[self dbPath]];
    
    if (nil == db) {
        return NO;
    }
    
    
    sqlite3_stmt *stmt = nil;
    
    int status = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (status != SQLITE_OK) {
        NSLog(@"prepare_step失败 %d:'%s' in %@",status, sqlite3_errmsg(db), [self class]);
        return NO;
    }
    
    if (nil != values) {
        int index = 1;
        for (NSString *text in values) {
            [self bindText:text ToStmt:stmt atIndex:index++];
        }
    }
    
    status = sqlite3_step(stmt);
    if (status != SQLITE_DONE){
        NSLog(@"insert error %d:'%s' in %@",status, sqlite3_errmsg(db), [self class]);
        return NO;
    }
    sqlite3_finalize(stmt);
    
    
    db = nil;
    
    return YES;
}

+ (NSMutableArray *)prepare_step_select:(NSString *)sql values:(NSArray *)values block:(id (^)(sqlite3_stmt * stmt_block))block funPoint:(id(*)(sqlite3_stmt *stmt_funPoint))funPoint
{
//    NSAssert(block && funPoint, @"block and funPoint cannot be nil at the same time!");
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    sqlite3 *db = [self databaseWithPath:[self dbPath]];
    
    if (nil == db) {
        return result;
    }
    
    
    sqlite3_stmt *stmt = nil;
    
    int status = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (status != SQLITE_OK) {
        NSLog(@"error %d: %s happen in method: %@ %@",status, sqlite3_errmsg(db), [self class],NSStringFromSelector(_cmd));
        return result;
    }
    
    
    if (nil != values) {
        int index = 1;
        for (NSString *text in values) {
            [self bindText:text ToStmt:stmt atIndex:index++];
        }
    }
    
    
    status = sqlite3_step(stmt);
    while (status == SQLITE_ROW){
        if (block) { //block
            id info = block(stmt);
            [result addObject:info];
        }else{      //funPoint
            id info = funPoint(stmt);
            [result addObject:info];
        }
        
        status = sqlite3_step(stmt);
    }
    
    if (status != SQLITE_DONE){ //select时候，肯定会done,所以可省这行代码
        NSLog(@"select error %d:'%s' in %@",status, sqlite3_errmsg(db), [self class]);
        return nil;
    }else{
        NSLog(@"从头到尾搜索完成");
    }
    
    sqlite3_finalize(stmt);
    
    
    db = nil;
    
    return result;
}

+ (sqlite3 *)databaseWithPath:(NSString *)dbPath{
    sqlite3 *db = nil;
    
    int status = sqlite3_open([dbPath UTF8String], &db);
    if (status != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"datebase open error %d: %s happen in method: %@ %@",status, sqlite3_errmsg(db), [self class],NSStringFromSelector(_cmd));
    }
    
    return db;
}


+ (NSString *)dbPath
{
    NSAssert(dbName_sqlite, @"dbName cannot be nil!");
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:dbName_sqlite];
    
    NSLog(@"数据库存放路径dbPath = %@",dbPath);
    if (![fm fileExistsAtPath:dbPath]) {
        [fm createFileAtPath:dbPath contents:nil attributes:nil]; //开始创建文件
    }
    
    return dbPath;
}




#pragma mark - 绑定数据到stm中
+ (void)bindText:(NSString *)text ToStmt:(sqlite3_stmt *)stmt atIndex:(int)index{
    if (text == nil) {
        NSLog(@"bind error: %@ stmt[%d] == nil", [self class], index);
        return;
    }
    if ((NSNull *)text == [NSNull null]) {
        NSLog(@"bind error: %@ stmt[%d] == NSNull", [self class], index);
        return;
    }
    
    if ([text isKindOfClass:[NSNumber class]]) {
        NSLog(@"bind error: %@ stmt[%d]的字段类型是NSNumber", [self class], index);
    }
    
    
    sqlite3_bind_text(stmt, index, [text UTF8String], -1, NULL);
}


+ (void)bindImage:(UIImage *)image ToStmt:(sqlite3_stmt *)stmt atIndex:(int)index{
    if (image == nil) {
        NSLog(@"bind error: %@ stmt[%d] == nil", [self class], index);
        return;
    }
    
    NSData *data = UIImagePNGRepresentation(image);
    sqlite3_bind_blob(stmt, index++, [data bytes], (int)[data length], NULL);
}



#pragma mark - 从stmt中获取数据
+ (NSString *)getTextFromStmt:(sqlite3_stmt *)stmt atIndex:(int)index{
    char *ctext = (char *)sqlite3_column_text(stmt, index);
    if (ctext == nil) {
        NSLog(@"column error: %@ stmt[%d] == nil", [self class], index);
        return nil;
    }
    NSString *text = [NSString stringWithUTF8String:ctext];
    return text;
}


+ (UIImage *)getImageFromStmt:(sqlite3_stmt *)stmt atIndex:(int)index{
    Byte *byte = (Byte *)sqlite3_column_blob(stmt, index);
    int length = sqlite3_column_bytes(stmt, index);
    NSData *data = [NSData dataWithBytes:byte length:length];
    //NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}




@end
