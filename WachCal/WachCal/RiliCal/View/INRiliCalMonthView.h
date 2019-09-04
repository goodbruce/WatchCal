//
//  INRiliCalMonthView.h
//  ticdiary
//
//  Created by guobingwei on 2019/1/9.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "SDBaseView.h"
#import "SDCalculationUtil.h"

#define kCalRowNumber 6
#define kCalColNumber 7

static CGFloat kRiliCalOMaiginPadding = 10.0;

@interface INRiliCalDayButton : UIControl

@property (nonatomic, assign) NSString *day;
@property (nonatomic, assign) NSString *cnDay;
@property (nonatomic, strong) UIColor *dayTextColor;
@property (nonatomic, strong) UIColor *cnDayTextColor;

@property (nonatomic, strong) NSString *yearMonthDay;

//如果是当前日期
@property (nonatomic, assign) BOOL isCurrentDay;

- (instancetype)initWithFrame:(CGRect)frame;

@end

/**
 日历
 */
@protocol INRiliCalMonthViewDelegate;
@interface INRiliCalMonthView : SDBaseView

@property (nonatomic, weak) id<INRiliCalMonthViewDelegate>monthDelegate;
//月份
@property (nonatomic, strong) NSDate *monthDate;

//标记当前显示的月的day显示为选中状态
- (void)markSelectedStatus:(NSString *)yearMonthDay;

@end

@protocol INRiliCalMonthViewDelegate <NSObject>

- (void)updateSelectedYearMonthDay:(NSString *)yearMonthDay;

@end
