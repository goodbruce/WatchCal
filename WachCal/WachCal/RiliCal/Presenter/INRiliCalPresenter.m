//
//  INRiliCalPresenter.m
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "INRiliCalPresenter.h"
#import "INRiliCalTableViewCell.h"
#import "SDCalculationUtil.h"

static CGFloat kRiliCalDayDiarySectionHeight = 60.0;

@interface INRiliCalPresenter ()<INRiliCalTableViewCellDelegate>

@end

@implementation INRiliCalPresenter

- (void)loadDayDiarys:(NSString *)yearMonthDay {
    __weak typeof(self) weakSelf = self;
    
}

#pragma mark - RIlICal
- (void)loadCurrentDate {
    NSString *nowYearMonthDay = [SDCalculationUtil yearMonthDayStringFormatter:[NSDate date]];
    [self updateSelectedYearMonthDay:nowYearMonthDay];
    [self loadDayDiarys:nowYearMonthDay];
}

- (void)rebackTodayMonth {
    if (self.calView.calScrollView.calHeaderView.isAnimationing) {
        return;
    }
    [self.calView.calScrollView.calHeaderView reloadTodayData];
    [self loadCurrentDate];
}

#pragma mark - UITableView delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 1) {
        CGFloat cellHeight = (kScreenHeight - [SDBaseView navBarHeight] - self.calView.calScrollView.headerHeight);
        CGFloat oneCellHeight = 100.0;
        if (indexPath.row == 0) {
            return oneCellHeight;
        }
        return cellHeight - oneCellHeight;
    }
    return 0.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *cellIdentifier = @"INRiliCalTableViewCell";
        INRiliCalTableViewCell *cell = (INRiliCalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[INRiliCalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *chinaeseDay = self.calInteractor.calDayItemViewModel.chinaeseDay;
        NSString *jieqiDay = self.calInteractor.calDayItemViewModel.jieqiDay;
        NSString *holiDay = self.calInteractor.calDayItemViewModel.holiDay;
        
        cell.title = @"";
        cell.content = @"";
        
        if (indexPath.row == 0) {
            cell.maskColor = [UIColor colorWithHexString:@"59493f" alpha:0.25];
            cell.title = [NSString stringWithFormat:@"%@ %@ %@",(holiDay?holiDay:@""),(jieqiDay?jieqiDay:@""),(chinaeseDay?chinaeseDay:@"")];
            cell.content = [NSString stringWithFormat:@"这一天 你写了 %lu 篇日记",(unsigned long)self.calInteractor.dayDiarySouces.count];
        } else if (indexPath.row == 1) {
            cell.maskColor = [UIColor colorWithHexString:@"ff3a27" alpha:0.25];
            if (holiDay && holiDay.length > 0) {
                cell.title = @"「宜旅行」";
                
                int aIndex = (arc4random() % 3);
                if (aIndex == 0) {
                    cell.content = @"旅行是一种心态的调整，让你看到更精彩的世界。";
                } else if (aIndex == 1) {
                    cell.content = @"旅行，让你活力满满，让你的每一天都充满力量。";
                } else if (aIndex == 2) {
                    cell.content = @"旅行，为你的心“保鲜”，让心灵与大自然合二为一。";
                }
            } else {
                cell.title = @"「宜放松心情」";
                int aIndex = (arc4random() % 3);
                if (aIndex == 0) {
                    cell.content = @"福是来自一颗懂得布施的心。";
                } else if (aIndex == 1) {
                    cell.content = @"只需要一道曙光，就可以打开心结。";
                } else if (aIndex == 2) {
                    cell.content = @"你，来到我的世界，停留了一秒，看到你的回眸一笑，从此心随你动。";
                }
            }
        }
        
        cell.showBottomArrow = NO;
        cell.showMark = NO;
        
        if (indexPath.row == 0) {
            cell.showMark = YES;
        }
        
        if (indexPath.row == 1) {
            
        }
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"defaultCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    }
}


#pragma mark - INRiliCalViewDelegate
- (void)updateNavDidShowDate:(NSDate *)date {
    NSString *showYearMoth = [SDCalculationUtil yearMonthFormatter:date];
//    if (self.controllerReloadHandler) {
//        self.controllerReloadHandler(showYearMoth, kUpdateNavigationTitleIdentifier);
//    }
    
    NSString *nowYearMoth = [SDCalculationUtil yearMonthFormatter:[NSDate date]];
    NSString *nowYearMothDay = [SDCalculationUtil yearMonthDayStringFormatter:[NSDate date]];
    //当前月和切换的月份一致的时候，显示当前时间
    if (nowYearMoth && [nowYearMoth isEqualToString:showYearMoth]) {
        //[self updateSelectedYearMonthDay:nowYearMothDay];
        [self.calView.calScrollView.calHeaderView markSelectedStatus:nowYearMothDay];
    } else {
        //不一致的情况，显示当月的1号
        NSString *showYearMonthDay = [NSString stringWithFormat:@"%@-01",showYearMoth];
        //[self updateSelectedYearMonthDay:showYearMonthDay];
        [self.calView.calScrollView.calHeaderView markSelectedStatus:showYearMonthDay];
    }
}

#pragma mark - INRiliCalMonthViewDelegate
- (void)updateSelectedYearMonthDay:(NSString *)yearMonthDay {
    NSDate *selectedDate = [SDCalculationUtil yearMonthDayFormatter:yearMonthDay];
    SDCalHolidayItem *item = [SDCalculationUtil getLunarSpecialDate:selectedDate];
    NSString *jieqi;
    if (item) {
        //如果有二十四节气
        jieqi = item.showDayString;
    }
    
    SDCalHolidayItem *hitem = [SDCalculationUtil calculationChinaCalendarWithDate:selectedDate dispalyHoliday:YES];
    self.calInteractor.calDayItemViewModel.jieqiDay = jieqi;
    self.calInteractor.calDayItemViewModel.chinaeseDay = hitem.chaineseDay;
    self.calInteractor.calDayItemViewModel.holiDay = hitem.holiDay;
    self.calInteractor.calDayItemViewModel.weekDay = hitem.weekDayString;
    
    NSArray *tmpArray = [(yearMonthDay?yearMonthDay:@"") componentsSeparatedByString:@"-"];
    if (tmpArray.count == 3) {
        self.calInteractor.calDayItemViewModel.day = [tmpArray objectAtIndex:2];
    }
    self.calInteractor.calDayItemViewModel.yearMonthDay = yearMonthDay;

    [self loadDayDiarys:yearMonthDay];
    [self.calView.calScrollView.contentTableView reloadData];
}

#pragma mark - SETTER/GETTER
- (INRiliCalView *)calView {
    if (!_calView) {
        _calView = [[INRiliCalView alloc] initWithFrame:CGRectZero];
    }
    return _calView;
}

- (INRiliCalInteractor *)calInteractor {
    if (!_calInteractor) {
        _calInteractor = [[INRiliCalInteractor alloc] init];
    }
    return _calInteractor;
}

@end
