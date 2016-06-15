# CommonFMDBUtil
包含CommonFMDBUtil和CommonSqliteUtil,可任选其一来操作数据库


方法：
两个类的使用精髓，都是注重在编辑sql语句上。
附：
```
CommonSqliteUtil.podspec别忘了加 s.libraries = "sqlite3"
```

``` 
    Readme.md编辑方法：
    ①##是标题，#号的多少表示标题的大小，越多越小
    ②一对```是中间区域加灰色底框，这个常用语突出显示方法实现
    ③一对`也是中间区域加灰色底框，这个常用于突出显示方法名。如:`commonAdView_setImageView: withImagePath:`
    ④一对[]加一对()表示链接名及链接地址，如[CocoaPods](http://cocoapods.org)
    ⑤图片：感叹号!加一对[],加(),()中的内容为图片当前路径，及在网页上鼠标悬停图片上时，显示的名字
        ## Screenshots
        ![Example](./Screens/example.gif "Example View")
        ![Example](./Screens/example.png "Example View")
    ⑥点：一个-开头
``` 

## Example 
``` 
#pragma mark - insert

+ (BOOL)insertInfo:(AccountInfo *)info
{
    NSAssert(info, @"info cannot be nil!");

    NSString *sql = [NSString stringWithFormat:
@"INSERT OR REPLACE INTO ACCOUNT (uid, name, email, pasd, imageName, imageUrl, imagePath, modified, execTypeL) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", info.uid, info.name, info.email, info.pasd, info.imageName, info.imageUrl, info.imagePath, info.modified, info.execTypeL];//DB Error: 1 "unrecognized token: ":"" 即要求插入的字符串需加引号'，而对于表名，属性名，可以不用像原来那样添加。

    return [CommonFMDBUtil insert:sql];
}
``` 

``` 
#pragma mark - remove

+ (BOOL)removeInfoWhereName:(NSString *)name
{
    NSAssert(name, @"name cannot be nil!");

    NSString *sql = [NSString stringWithFormat:@"delete from ACCOUNT where name = '%@'",name];

    return [CommonFMDBUtil remove:sql];
}
``` 

``` 
#pragma mark - update

+ (BOOL)updateInfoExceptUID:(AccountInfo *)info whereUID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:
                    @"UPDATE ACCOUNT SET name = '%@', email = '%@', pasd = '%@', imageName = '%@', imageUrl = '%@', imagePath = '%@' WHERE uid = '%@'",
                    info.name, info.email, info.pasd, info.imageName, info.imageUrl, info.imagePath, uid];
    return [CommonFMDBUtil update:sql];
}

+ (BOOL)updateInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                        @"update ACCOUNT set imagePath = '%@' where uid = '%@'", imagePath, uid];
    return [CommonFMDBUtil update:sql];
}


+ (BOOL)updateInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                    @"update ACCOUNT set imageUrl = '%@' where uid = '%@'", imageUrl, uid];
    return [CommonFMDBUtil update:sql];
}

+ (BOOL)updateInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                        @"update ACCOUNT set execTypeL = '%@' where uid = '%@'", execTypeL, uid];
    return [CommonFMDBUtil update:sql];
}
``` 

``` 
#pragma mark - query

+ (NSDictionary *)selectInfoWhereUID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ACCOUNT where uid = '%@'", uid];

    NSArray *result = [CommonFMDBUtil query:sql];
    return result.count > 0 ? result[0] : nil;
}


+ (UIImage *)selectImageWhereName:(NSString *)name
{
    NSString *sql = [NSString stringWithFormat:@"SELECT imagePath FROM ACCOUNT where name = '%@'", name];

    NSArray *result = [CommonFMDBUtil query:sql];
    NSString *imagePath = result.count > 0 ?
                [result[0] objectForKey:@"imagePath"] : [[NSBundle mainBundle] pathForResource:@"people_logout" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];

    return image;
}
``` 


**More usage reference test case.**

## Attention

Does not support model collections, such as NSArray&lt;User&gt;* users;

## Author

[李xx](http://)

## License

MIT



