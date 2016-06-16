//
//  NSDate+Util.m
//  SFPay
//
//  Created by ssf-2 on 14-11-13.
//  Copyright (c) 2014年 SF. All rights reserved.
//

#import "NSDate+Ext.h"
#import "StringUtiles.h"

@implementation NSDate (Ext)

+ (NSDate *)dateWithString:(NSString *)str format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    return [dateFormatter dateFromString:str];
}

+ (NSString *)dateToString:(NSDate *)date format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)dateWithTimeInterval:(NSTimeInterval)interval format:(NSString *)formating
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    return [dateFormatter stringFromDate:date];
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)str format:(NSString *)formating
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formating];
    NSDate *date = [dateFormatter dateFromString:str];
    
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f",timestamp];
    return [time doubleValue];
}

+ (NSDate *)dateWithStringMuitiform:(NSString *)str
{
    NSDate *time = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    time = [dateFormatter dateFromString:str];
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyyMMdd HH:mm:ss"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"MMdd"];
        time = [dateFormatter dateFromString:str];
    }
    if (time == nil) {
        [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
        time = [dateFormatter dateFromString:str];
    }
    return time;
}

+(NSString *)dateToSpecialTime:(NSDate *)time{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateStyle:NSDateFormatterMediumStyle];
    [inputFormatter setTimeStyle:NSDateFormatterShortStyle];
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDateComponents *nowCom = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *comCom = [calendar components:unitFlags fromDate:time];
    
    NSString *returnStr =@"";
    
    //如果为同一天
    if (([nowCom day] == [comCom day]) && ([nowCom month] == [comCom month]) && ([nowCom year]  == [comCom year])) {
        [inputFormatter setDateFormat:@"HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([nowCom year]  == [comCom year]) && ([nowCom day] == [comCom day] -1) && ([nowCom month] == [comCom month])){
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([nowCom year]  == [comCom year])){
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else{
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];

    }
    return returnStr;
}

+(NSString *)gainSystemTime
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *requestTime = [formatter stringFromDate:[NSDate date]];
    
    return requestTime;
}

+(NSString *)dateToNewSpecialTime:(NSDate *)time{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    
    NSDate *nowDate = [NSDate date];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init] ;
    [inputFormatter setDateStyle:NSDateFormatterMediumStyle];
    [inputFormatter setTimeStyle:NSDateFormatterShortStyle];
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDateComponents *nowCom = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *comCom = [calendar components:unitFlags fromDate:time];
    NSDateComponents *yesterdayCom = [calendar components:unitFlags fromDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:nowDate]];
    
    NSString *returnStr =@"";
    
    //如果为同一天
    if (([nowCom day] == [comCom day]) && ([nowCom month] == [comCom month]) && ([nowCom year]  == [comCom year])) {
        [inputFormatter setDateFormat:@"今天 HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([yesterdayCom year]  == [comCom year]) && ([yesterdayCom day] == [comCom day]) && ([yesterdayCom month] == [comCom month])){
        [inputFormatter setDateFormat:@"昨天 HH:mm"];
        returnStr = [inputFormatter stringFromDate:time];
    }else if(([nowCom year]  == [comCom year])){
        [inputFormatter setDateFormat:@"MM-dd"];
        returnStr = [inputFormatter stringFromDate:time];
    }else{
        [inputFormatter setDateFormat:@"yyyy-MM-dd"];
        returnStr = [inputFormatter stringFromDate:time];
        
    }
    return returnStr;
}

//
+(NSTimeInterval)javaTimestampFormatToIOSTimestamp:(NSString*)javaTimestap{
    javaTimestap = [NSString stringWithFormat:@"%.0f",[javaTimestap doubleValue]];
    
    if ([javaTimestap length] < 5) {
        return 0;
    }
    NSTimeInterval iosTimestamp = [[javaTimestap substringToIndex:javaTimestap.length-3] doubleValue];
    return iosTimestamp;
}

+(NSString*)timestampFormat:(NSString*)timestampStr formatString:(NSString*)formatStr{
    if ([NSString isEmpty:timestampStr]) {
        timestampStr = @"";
    }
    NSTimeInterval applyTimestamp = [NSDate javaTimestampFormatToIOSTimestamp:timestampStr];
    NSString *dateStr = [NSDate dateWithTimeInterval:applyTimestamp format:formatStr];
    return dateStr;
}


+(NSDate*)timeStampTransformToDate:(NSString*)timestampStr{
    
    if ([NSString isEmpty:timestampStr]) {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
    if ([timestampStr length] < 5) {
        return [NSDate dateWithTimeIntervalSince1970:0];
    }
    NSTimeInterval iosTimestamp = [[timestampStr substringToIndex:[timestampStr length]-3] doubleValue];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:iosTimestamp];
    
    return date;
}





//年齢計算
+(NSString*)getAgeByBirthDay:(NSDate*)birthDay{

    NSDate *birthday = birthDay;
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:birthday toDate:today options:0];
    return [NSString stringWithFormat:@"%zi",components.year];
}




@end
