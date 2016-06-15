//
//  UIDevice+Utility.m
//  RSPay
//
//  Created by RanSong on 14/12/24.
//  Copyright (c) 2014年 RanSong. All rights reserved.
//

#import "UIDevice+Ext.h"
#import <sys/sysctl.h>
#include <sys/param.h>
#include <sys/mount.h>

#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"



@implementation UIDevice (Ext)

- (NSString *)deviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = 6; //CTL_HW;
    mib[1] = 1; //HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone2G";    //(A1203)
    
    if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone3G";   //(A1241/A1324)
    
    if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone3GS";  //(A1303/A1325)
    
    if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone4";   //(A1332)
    
    if ([platform isEqualToString:@"iPhone3,2"])
        return @"iPhone4";  //(A1332)
    
    if ([platform isEqualToString:@"iPhone3,3"])
        return @"iPhone4";  //(A1349)
    
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone4S";//(A1387/A1431)
    
    if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone5"; //(A1428)
    
    if ([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone5"; //(A1429/A1442)
    
    if ([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone5c";//(A1456/A1532)
    
    if ([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone5c";//(A1507/A1516/A1526/A1529)
    
    if ([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone5s";//(A1453/A1533)
    
    if ([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone5s";//(A1457/A1518/A1528/A1530)
    
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone6Plus";//(A1522/A1524)
    
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone6";  //(A1549/A1586)
    
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";   //(A1213)
    
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";  //(A1288)
    
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";  //(A1318)
    
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";  //(A1367)
    
    if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";  //(A1421/A1509)
    
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad 1G";        //(A1219/A1337)
    
    if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2";        //(A1395)
    
    if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2";        //(A1396)
    
    if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2";       //(A1397)
    
    if ([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2";      //(A1395+New Chip)
    
    if ([platform isEqualToString:@"iPad2,5"])
        return @"iPad Mini 1G"; //(A1432)
    
    if ([platform isEqualToString:@"iPad2,6"])
        return @"iPad Mini 1G"; //(A1454)
    
    if ([platform isEqualToString:@"iPad2,7"])
        return @"iPad Mini 1G"; //(A1455)
    
    if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3";       //(A1416)
    
    if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3";       //(A1403)
    
    if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3";       //(A1430)
    
    if ([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4";       //(A1458)
    
    if ([platform isEqualToString:@"iPad3,5"])
        return @"iPad 4";      //(A1459)
    
    if ([platform isEqualToString:@"iPad3,6"])
        return @"iPad 4";      //(A1460)
    
    if ([platform isEqualToString:@"iPad4,1"])
        return @"iPad Air";   //(A1474)
    
    if ([platform isEqualToString:@"iPad4,2"])
        return @"iPad Air";   //(A1475)
    
    if ([platform isEqualToString:@"iPad4,3"])
        return @"iPad Air";   //(A1476)
    
    if ([platform isEqualToString:@"iPad4,4"])
        return @"iPad Mini 2G"; //(A1489)
    
    if ([platform isEqualToString:@"iPad4,5"])
        return @"iPad Mini 2G"; //(A1490)
    
    if ([platform isEqualToString:@"iPad4,6"])
        return @"iPad Mini 2G"; //(A1491)
    
    if ([platform isEqualToString:@"i386"])
        return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return platform;
}

- (NSString *)deviceSystemVersion
{
    return [self systemVersion];
}

- (float)deviceWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

- (float)deviceHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

- (NSString *)deviceType
{
    NSString *platform = [self deviceModel];
    
    NSRange range = [platform rangeOfString:@"iPhone"];
    if ( range.length != NSNotFound )
        return @"iPhone";
    
    range = [platform rangeOfString:@"iPod Touch"];
    if ( range.length != NSNotFound )
        return @"iPod Touch";
    
    range = [platform rangeOfString:@"iPad Mini"];
    if ( range.length != NSNotFound )
        return @"iPad Mini";
    
    range = [platform rangeOfString:@"iPad"];
    if ( range.length != NSNotFound )
        return @"iPad";
    
    range = [platform rangeOfString:@"iPad Air"];
    if ( range.length != NSNotFound)
        return @"iPad Air";
    
    return @"iPhone";
}

- (NSString*)deviceFreeSpaceInBytes {
    
    struct statfs buf;
    
    long long freespace = -1;
    
    if(statfs("/", &buf) >= 0){
        
        freespace = (long long)buf.f_bsize * buf.f_bfree;
        
    }
    
    return [NSString stringWithFormat:@"%lld",freespace];
    
}


//手机硬盘总容量
- (NSString*)deviceTotalDiskSpaceInBytes {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    struct statfs tStats;
    
    statfs([[paths lastObject] cString], &tStats);
    
    long long totalSpace = tStats.f_blocks * tStats.f_bsize;
    
    return [NSString stringWithFormat:@"%lld",totalSpace];
    
}

//App版本号
- (NSString*)appVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) || (interface->ifa_flags & IFF_LOOPBACK)) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                char addrBuf[INET6_ADDRSTRLEN];
                if(inet_ntop(addr->sin_family, &addr->sin_addr, addrBuf, sizeof(addrBuf))) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, addr->sin_family == AF_INET ? IP_ADDR_IPv4 : IP_ADDR_IPv6];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    // The dictionary keys have the form "interface" "/" "ipv4 or ipv6"
    return [addresses count] ? addresses : nil;
}


@end





