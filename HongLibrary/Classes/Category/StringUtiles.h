//
//  StringUtiles.h
//  Pods
//
//  Created by ehmo on 16/6/16.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Utiles)


// 给字符串去除空格
- (NSString*)trimCharacters;

// 判断字符串是否包含另外一段短字符串
- (BOOL)containsString:(NSString *)aString;

// URL encode
- (NSString *)URLEncode;

// sha1 加密
- (NSString *)sha1;

// 判断字符串是否为空
+ (BOOL)isEmpty:(NSString *)string;

//判断是否为整形：
+ (BOOL)isPureLong:(NSString*)string;

// 校验手机号码的合法性
-(BOOL)validateMobile;

// data 转换成字符串
+ (NSString *)toJSONString:(id)theData;

// json 格式的字符串转换成字典
- (id)JSONValue;

// 按照文字首字母排序
+ (NSDictionary *)getChineseStringArr:(NSArray *)dataSource  key:(NSString *)key;

// 校验身份证号码的合法性
-(BOOL)validateIDCardNumber:(NSString *)value;

// 校验香港身份证号码的合法性
-(BOOL)validateHKIDCardNumber:(NSString *)value;

// 校验台湾身份号码的合法性 8位或10位，纯数字
-(BOOL)validateTWIDCardNumber:(NSString *)value;

// 校验密码设置的难易度
-(NSString *)validLoginPwd:(NSString *)value andMobile:(NSString *)mobile;

//支付密码设置规则：支付密码为6位数字，不能包含有连续4位及以上顺序或逆序的数字，给出提醒；
-(NSInteger)appValidPaymentPwd:(NSString *)pwd;

+ (NSMutableAttributedString *)nameFont:(UIFont *)font name:(NSString *)name string:(NSString *)string;

+ (NSMutableAttributedString *)nameColor:(UIColor *)color name:(NSString *)name string:(NSString *)string;

//32位MD5加密方式
- (NSString*)MD5;

// RSA 加密
+(NSString*)RSA:(NSString *)inputText;

//金额输入规范
+ (NSString *)menoyRule:(NSString *)text;

//保留小数有效位
+ (NSString *)changeFloat:(NSString *)stringFloat;

//  获取字符创的byte长度
+(NSUInteger)getChineseBytes;

@end
