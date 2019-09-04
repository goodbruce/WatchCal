//
//  INRiliCalHeaderView.h
//  ticdiary
//
//  Created by guobingwei on 2019/1/7.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "SDBaseView.h"
#import "INRiliCalMonthView.h"
#import "SDCalculationUtil.h"

typedef void(^INUpdateCurrentDateBlock)(NSDate *showDate);

#define kCalCollectionTAGIndex 11021

@interface INRiliCalHeaderView : SDBaseView

@property (nonatomic, weak) id subDelegate;

@property (nonatomic, copy) INUpdateCurrentDateBlock updateDateBlock;

@property (nonatomic, strong) UIImageView *weekBGImageView;

@property (nonatomic, strong) UIImageView *maskBGImageView;

//卡片数组，默认显示3个卡片，移除一张卡片，在底部插入一张
@property (nonatomic, strong) NSMutableArray *monthCards;

//偏移量
@property (nonatomic, assign) CGFloat contentOffsetY;

@property (nonatomic, assign) BOOL isAnimationing;

- (instancetype)initWithFrame:(CGRect)frame;

- (NSDate *)getShowCurrentDate;

//回到当前月份
- (void)reloadTodayData;


//标记当前显示的月的day显示为选中状态
- (void)markSelectedStatus:(NSString *)yearMonthDay;


@end
