//
//  NSDate+KCExtension.m
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/6.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "NSDate+KCExtension.h"

@implementation NSDate (KCExtension)

+ (NSString *)kc_dateStringWithTimeInterval:(NSTimeInterval)time formatter:(NSString *)fmt
{
    return [[NSDate dateWithTimeIntervalSince1970:time] kc_dateStringWithFormatter:fmt];
}

- (NSString *)kc_dateStringWithFormatter:(NSString *)fmt
{
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.dateFormat = fmt;
    return [dateFmt stringFromDate:self];
}

/**
 *  判断某个时间是否为今年
 */
- (BOOL)kc_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
- (BOOL)kc_isYesterday { return [[NSCalendar currentCalendar] isDateInYesterday:self]; }

/**
 *  判断某个时间是否为今天
 */
- (BOOL)kc_isToday { return [[NSCalendar currentCalendar] isDateInToday:self]; }

- (NSString *)kc_dateStringFromNowWithPrettyFormatter
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 微博的创建日期
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:self toDate:now options:0];
    
    if ([self kc_isThisYear]) { // 今年
        if ([self kc_isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:self];
        } else if ([self kc_isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:self];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:self];
    }

}


+ (NSDate *)kc_todayZero
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSDate *today = [calendar dateFromComponents:components];
    
    return today;

}

@end
