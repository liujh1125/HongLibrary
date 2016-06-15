//
//  DefineMacro.h
//  Liujh
//
//  Created by Liujh on 14-4-21.
//  Copyright (c) 2014年 Liujh. All rights reserved.
//

#ifndef DefineMacro
#define DefineMacro

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//获取屏幕 宽度、高度
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
#define WIDTH   [UIScreen mainScreen].bounds.size.width

// rgb颜色转换（16进制->10进制）
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

///////////////////////////////////////////////////////////////////////////////////////////////////
// Color helpers
#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]


//判断系统版本
#define IS_IOS_AT_LEAST(ver)    ([[[UIDevice currentDevice] systemVersion] compare:ver] != NSOrderedAscending)
#define IS_IOS8LATER                 (__IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 && IS_IOS_AT_LEAST(@"8.0"))
#define IS_IOS7LATER                 (__IPHONE_OS_VERSION_MAX_ALLOWED >= 70000 && IS_IOS_AT_LEAST(@"7.0"))
#define IS_IOS6LATER                 (__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000 && IS_IOS_AT_LEAST(@"6.0"))

//通知消息
#define IPHONE4_WIDTH  320
#define IPHONE4_HEIGHT 480
#define IPHONE5_HEIGHT 568
#define IPHONE6_WIDTH  375
#define IPHONE6_HEIGHT 667
#define IPHONE6P_WIDTH  414
#define IPHONE6P_HEIGHT 736



#endif
