//
//  SDCalculationUtil.h
//  ticdiary
//
//  Created by guobingwei on 2019/1/2.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+SDFrame.h"

@interface SDCalHolidayItem: NSObject

@property (nonatomic, strong) NSString *cnDayString;
@property (nonatomic, strong) NSString *showDayString;
@property (nonatomic, strong) NSString *colorString;
@property (nonatomic, strong) NSString *colorBGString;

//农历日期
@property (nonatomic, strong) NSString *chaineseDay;

//节日
@property (nonatomic, strong) NSString *holiDay;

//节气
@property (nonatomic, strong) NSString *jieqiDay;

//weekday
@property (nonatomic, strong) NSString *weekday;

//weekday
@property (nonatomic, strong) NSString *weekDayString;

@end

@interface SDCalculationUtil : NSObject

+ (NSDateFormatter *)dateFormatter;

+ (NSDateFormatter *)strDateFormatter;

+ (NSDate *)baseDate;

+ (NSUInteger)year:(NSDate *)date;

+ (NSUInteger)month:(NSDate *)date;

+ (NSUInteger)day:(NSDate *)date;

+ (NSUInteger)dayInWeek:(NSDate *)date;

+ (NSString *)yearMonthFormatter:(NSDate *)date;

+ (NSDate *)yearMonthFormatterString:(NSString *)dateString;

+ (NSDate *)yearMonthDayFormatter:(NSString *)dateString;

+ (NSString *)yearMonthDayStringFormatter:(NSDate *)date;

+ (BOOL)isCurrentDay:(NSString *)dateString;

#pragma mark - 计算本月第一天是周几
+ (NSDateComponents *)calculationThisMonthFirstDayInWeek:(NSDate *)date;

#pragma mark - 计算二十四节气的具体日期
/**
 * @param year 年份
 * @param index 节气索引，0代表小寒，1代表大寒，其它节气按照顺序类推
 */
+ (NSString *)calculationSolarTermsWithYear:(NSUInteger)year solarTermsIndex:(NSUInteger)index;

#pragma mark - 计算农历日期
+ (SDCalHolidayItem *)calculationChinaCalendarWithDate:(NSDate *)date dispalyHoliday:(BOOL)display;

//获取二十四节气
+ (SDCalHolidayItem *)getLunarSpecialDate:(NSDate *)date;


#pragma mark - 日历
+ (int)getNumberOfMonth:(NSDate*)date;

+ (NSDate *)getMonthFirstDay:(NSDate*)tdate;

+ (int)getWeekOfMonthFirstDay:(NSDate*)tdate;

+(int)getNumberDaysOfLastMonth:(NSDate*)tdate;

+(NSDate*)getDateOfNextMonth:(NSDate*)tdate;

+(NSDate*)getDateOfLastMonth:(NSDate*)tdate;

+(int)numDaysInMonth:(NSDate *)tdate;

+(NSDate *)dateStartOfDay:(NSDate *)date;

+(NSDate *)dateStartOfWeek;

+(NSDate *)dateEndOfWeek;

+(int)firstWeekDayInMonth:(NSDate*)tdate;

+(int)numRowsNumberOfMonth:(NSDate *)tdate;

@end
