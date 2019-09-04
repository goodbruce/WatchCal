//
//  INRiliCalMonthView.m
//  ticdiary
//
//  Created by guobingwei on 2019/1/9.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "INRiliCalMonthView.h"

static CGFloat kDaySizeHeight = 20.0;
static CGFloat kCNDaySizeHeight = 15.0;
static CGFloat kCNDaySmallPadding = 2.0;
static CGFloat kBGSmallPadding = 5.0;
static CGFloat kDayMarginPadding = 10.0;
static CGFloat kBGMinPadding = 2.0;

@interface INRiliCalDayButton ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *cnDayLabel;

@end

@implementation INRiliCalDayButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgImageView];
        
        //日期
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dayLabel.font = UISYSFontSize(20);
        _dayLabel.textColor = [UIColor colorWithHexString:@"565656"];
        _dayLabel.backgroundColor = [UIColor clearColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_dayLabel];
        
        //农历日期
        _cnDayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _cnDayLabel.font = UISYSFontSize(12);
        _cnDayLabel.textColor = [UIColor colorWithHexString:@"A9A9A9"];
        _cnDayLabel.backgroundColor = [UIColor clearColor];
        _cnDayLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cnDayLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat sizeWidth = ceil(MIN(CGRectGetWidth(self.bounds) - 2*kBGMinPadding, CGRectGetHeight(self.bounds) - 2*kBGMinPadding));
    CGFloat bgOriginY = (CGRectGetHeight(self.bounds) - sizeWidth)/2;
    self.bgImageView.frame = CGRectMake(kBGMinPadding, bgOriginY, sizeWidth, sizeWidth);
    self.bgImageView.layer.cornerRadius = sizeWidth/2;
    self.bgImageView.layer.masksToBounds = YES;
    
    CGFloat originY = (CGRectGetHeight(self.bounds) - kDaySizeHeight - kCNDaySizeHeight)/2;
    self.dayLabel.frame = CGRectMake(kBGSmallPadding, originY, CGRectGetWidth(self.bounds) - 2*kBGSmallPadding, kDaySizeHeight);
    
    self.cnDayLabel.frame = CGRectMake(kBGSmallPadding, CGRectGetMaxY(self.dayLabel.frame), CGRectGetWidth(self.bounds) - 2*kBGSmallPadding, kCNDaySizeHeight);
}

- (void)setIsCurrentDay:(BOOL)isCurrentDay {
    _isCurrentDay = isCurrentDay;
    if (isCurrentDay) {
        self.dayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        self.cnDayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"59493f"];
    } else {
        self.bgImageView.backgroundColor = [UIColor clearColor];
        if (self.cnDayTextColor) {
            self.cnDayLabel.textColor = self.cnDayTextColor;
        } else {
            self.cnDayLabel.textColor = [UIColor colorWithHexString:@"A9A9A9"];
        }
        
        if (self.dayTextColor) {
            self.dayLabel.textColor = self.dayTextColor;
        } else {
            self.dayLabel.textColor = [UIColor colorWithHexString:@"363636"];
        }
    }
}

- (void)setDay:(NSString *)day {
    _day = (day?day:@"");
    self.dayLabel.text = _day;
    [self setNeedsLayout];
}

- (void)setCnDay:(NSString *)cnDay {
    _cnDay = (cnDay?cnDay:@"");
    self.cnDayLabel.text = _cnDay;
    [self setNeedsLayout];
}

- (void)setDayTextColor:(UIColor *)dayTextColor {
    _dayTextColor = dayTextColor;
    self.dayLabel.textColor = dayTextColor;
}

- (void)setCnDayTextColor:(UIColor *)cnDayTextColor {
    _cnDayTextColor = cnDayTextColor;
    self.cnDayLabel.textColor = cnDayTextColor;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.dayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        self.cnDayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
        self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"ff3a27"];
    } else {
        if (self.isCurrentDay) {
            self.dayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
            self.cnDayLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
            self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"59493f"];
        } else {
            self.bgImageView.backgroundColor = [UIColor clearColor];
            if (self.cnDayTextColor) {
                self.cnDayLabel.textColor = self.cnDayTextColor;
            } else {
                self.cnDayLabel.textColor = [UIColor colorWithHexString:@"A9A9A9"];
            }
            
            if (self.dayTextColor) {
                self.dayLabel.textColor = self.dayTextColor;
            } else {
                self.dayLabel.textColor = [UIColor colorWithHexString:@"363636"];
            }
        }
    }
}

@end

/**
 日历cell
 */
@interface INRiliCalMonthView ()

@property (nonatomic, strong) NSMutableArray *dayButtonViews;

@property (nonatomic, assign) int numbersOfRow;
@property (nonatomic, assign) int numberOfDays;
@property (nonatomic, assign) int weekOffirstDay;

@property (nonatomic, strong) NSString *yearMonth;

@end

@implementation INRiliCalMonthView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.exclusiveTouch = YES;
        self.dayButtonViews = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger index = 0; index < kCalRowNumber*kCalColNumber; index++) {
            INRiliCalDayButton *button = [[INRiliCalDayButton alloc] initWithFrame:CGRectZero];
            button.tag = index;
            [button addTarget:self action:@selector(dayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.dayButtonViews addObject:button];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnSizeWidth = (CGRectGetWidth(self.bounds) - 2*kRiliCalOMaiginPadding)/kCalColNumber;
    CGFloat btnSizeHeight = (CGRectGetHeight(self.bounds) - 2*kDayMarginPadding)/kCalRowNumber;
    if (self.numbersOfRow > 0) {
        btnSizeHeight = (CGRectGetHeight(self.bounds) - 2*kDayMarginPadding)/self.numbersOfRow;
    }
    
    NSInteger buttonCount = self.dayButtonViews.count;
    for (NSInteger index = 0; index < self.dayButtonViews.count; index++) {
        NSInteger row = index/kCalColNumber;
        NSInteger col = index%kCalColNumber;
        
        INRiliCalDayButton *button = [self.dayButtonViews objectAtIndex:index];
        button.frame = CGRectMake(kRiliCalOMaiginPadding + col*btnSizeWidth, kDayMarginPadding + row*btnSizeHeight, btnSizeWidth, btnSizeHeight);
    }
}

- (void)setMonthDate:(NSDate *)monthDate {
    _monthDate = (monthDate?monthDate:[NSDate date]);
    
    self.yearMonth = [SDCalculationUtil yearMonthFormatter:self.monthDate];
    int firstdayweek = [SDCalculationUtil getWeekOfMonthFirstDay:self.monthDate];
    DLog(@"firstdayweek:%d",firstdayweek);
    self.numbersOfRow = [SDCalculationUtil numRowsNumberOfMonth:self.monthDate];
    DLog(@"numbersOfRow:%d",self.numbersOfRow);
    
    int lastMonthNumberDay = [SDCalculationUtil getNumberDaysOfLastMonth:self.monthDate];
    
    
    self.numberOfDays = [SDCalculationUtil getNumberOfMonth:self.monthDate];
    
    // 星期几（注意，周日是“1”，周一是“2”。。。。）
    int preday = 0;
    if (firstdayweek == 2) {
        preday = 0;
    }
    else if(firstdayweek == 3)
    {
        preday = 1;
    }
    else if(firstdayweek == 4)
    {
        preday = 2;
    }
    else if(firstdayweek == 5)
    {
        preday = 3;
    }
    else if(firstdayweek == 6)
    {
        preday = 4;
    }
    else if(firstdayweek == 7)
    {
        preday = 5;
    }
    else if(firstdayweek == 1)
    {
        preday = 6;
    }
    
    int munbers = self.numberOfDays+preday;
    
    int numbersblocks = self.numbersOfRow*7;
    
    for (INRiliCalDayButton *button in self.dayButtonViews) {
        button.hidden = YES;
        button.selected = NO;
        button.isCurrentDay = NO;
    }
    
    for (int i = 0; i < numbersblocks; i++) {
        INRiliCalDayButton *button = [self.dayButtonViews objectAtIndex:i];
        button.day = @"";
        button.cnDayTextColor = [UIColor colorWithHexString:@"A9A9A9"];
        if (i<preday) {
            NSString *text = [NSString stringWithFormat:@"%d",lastMonthNumberDay-(preday-1)+i];
            //button.day = text;
        } else if(i>=munbers) {
            NSString *titletext = [NSString stringWithFormat:@"%d",i-munbers+1];
            //button.day = titletext;
        } else {
            NSString *titletext = [NSString stringWithFormat:@"%d",i-preday+1];
            NSString *tmpday;
            if([titletext intValue]<10) {
                tmpday = [NSString stringWithFormat:@"0%@",titletext];
            } else {
                tmpday = titletext;
            }
            NSString *yearMonthDay = [NSString stringWithFormat:@"%@-%@",self.yearMonth,tmpday];
            NSDate *dayDate = [SDCalculationUtil yearMonthDayFormatter:yearMonthDay];
            SDCalHolidayItem *cnDayItem = [SDCalculationUtil getLunarSpecialDate:dayDate];
            button.day = titletext;
            if (cnDayItem) {
                button.cnDay = cnDayItem.showDayString;
            } else {
                cnDayItem = [SDCalculationUtil calculationChinaCalendarWithDate:dayDate dispalyHoliday:YES];
                button.cnDay = cnDayItem.cnDayString;
            }
            
            BOOL isCurrentDay = [SDCalculationUtil isCurrentDay:yearMonthDay];

            UIColor *cnTextColor = [UIColor colorWithHexString:cnDayItem.colorBGString];
            cnTextColor = cnTextColor?cnTextColor:[UIColor colorWithHexString:@"A9A9A9"];
            button.cnDayTextColor = cnTextColor;
            button.hidden = NO;
            button.isCurrentDay = isCurrentDay;
            button.yearMonthDay = yearMonthDay;
        }
    }
    
    [self setNeedsLayout];
}

- (void)dayButtonAction:(INRiliCalDayButton *)dayButton {
    for (NSInteger index = 0; index < self.dayButtonViews.count; index++) {
        UIButton *button = [self.dayButtonViews objectAtIndex:index];
        if (dayButton.tag == button.tag) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    
    if (self.monthDelegate && [self.monthDelegate respondsToSelector:@selector(updateSelectedYearMonthDay:)]) {
        [self.monthDelegate updateSelectedYearMonthDay:dayButton.yearMonthDay];
    }
}

//标记当前显示的月的day显示为选中状态
- (void)markSelectedStatus:(NSString *)yearMonthDay {
    for (NSInteger index = 0; index < self.dayButtonViews.count; index++) {
        INRiliCalDayButton *button = (INRiliCalDayButton *)[self.dayButtonViews objectAtIndex:index];
        if (yearMonthDay && [yearMonthDay isEqualToString:button.yearMonthDay]) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    
    if (self.monthDelegate && [self.monthDelegate respondsToSelector:@selector(updateSelectedYearMonthDay:)]) {
        [self.monthDelegate updateSelectedYearMonthDay:yearMonthDay];
    }
}

@end
