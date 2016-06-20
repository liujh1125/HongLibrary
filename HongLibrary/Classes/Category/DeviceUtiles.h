//
//  UIDevice+Utility.h
//  RSPay
//
//  Created by RanSong on 14/12/24.
//  Copyright (c) 2014年 RanSong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Utiles)

/**
 *  获取设备型号
 *
 *  @return 返回设备型号
 */
- (NSString *)deviceModel;

/**
 *  获取设备操作系统版本
 *
 *  @return 返回操作系统版本
 */
- (NSString *)deviceSystemVersion;

/**
 *  获取设备屏幕宽
 *
 *  @return 返回屏幕宽
 */
- (float )deviceWidth;

/**
 *  获取设备屏幕高
 *
 *  @return 返回職高
 */
- (float )deviceHeight;

/**
 *  设备种类 eg: iPhone, iPad, iPad Mini, iPod Touch
 *
 *  @return 设备种类
 */
- (NSString *)deviceType;
/**
 *  手机硬盘总容量
 *
 *  @return 手机硬盘总容量
 */
- (NSString*)deviceTotalDiskSpaceInBytes;


/**
 *  手机硬盘剩余容量
 *
 *  @return 手机硬盘剩余容量
 */
- (NSString*)deviceFreeSpaceInBytes;

/**
 *  App 版本号
 *
 *  @return App 版本号
 */
- (NSString*)appVersion;


+ (NSString *)getIPAddress:(BOOL)preferIPv4;

+ (NSDictionary *)getIPAddresses;

@end




