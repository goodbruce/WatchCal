//
//  INRiliCalInteractor.m
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "INRiliCalInteractor.h"
#import "SDCalculationUtil.h"

@implementation INRiliCalInteractor

- (NSMutableArray *)monthDates {
    if (!_monthDates) {
        _monthDates = [NSMutableArray arrayWithCapacity:0];
        
        NSDate *currenDate = [NSDate date];
        NSMutableArray *tmpColors = [NSMutableArray arrayWithCapacity:0];
        NSDate *preDate = [SDCalculationUtil getDateOfLastMonth:currenDate];
        NSDate *nextDate = [SDCalculationUtil getDateOfNextMonth:currenDate];
        for (NSInteger index = 0; index < 3; index ++) {
            if (index == 0) {
                [tmpColors addObject:preDate];
            } else if (index == 1) {
                [tmpColors addObject:currenDate];
            } else if (index == 2) {
                [tmpColors addObject:nextDate];
            }
        }
        
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:tmpColors.count+2];
        if (tmpColors.count > 1) {
            NSDate *color = [tmpColors objectAtIndex:tmpColors.count-1];
            [itemArray addObject:color];
        }

        for (int i = 0; i < tmpColors.count; i++) {
            NSDate *color = [tmpColors objectAtIndex:i];
            [itemArray addObject:color];
        }
        //添加第一张图 用于循环
        if (tmpColors.count >1) {
            NSDate *color = [tmpColors objectAtIndex:0];
            [itemArray addObject:color];
        }
        [_monthDates addObjectsFromArray:itemArray];
        DebugLog(@"tmpColors:%@",tmpColors);
        DebugLog(@"_monthDates:%@",_monthDates);
    }
    return _monthDates;
}

- (INRiliCalDayItemViewModel *)calDayItemViewModel {
    if (!_calDayItemViewModel) {
        _calDayItemViewModel = [[INRiliCalDayItemViewModel alloc] init];
    }
    return _calDayItemViewModel;
}

- (NSMutableArray *)dayDiarySouces {
    if (!_dayDiarySouces) {
        _dayDiarySouces = [NSMutableArray arrayWithCapacity:0];
    }
    return _dayDiarySouces;
}

@end
