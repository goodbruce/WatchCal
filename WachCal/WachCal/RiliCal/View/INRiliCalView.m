//
//  INRiliCalView.m
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "INRiliCalView.h"

@interface INRiliCalView ()

@end

@implementation INRiliCalView

- (void)dealloc {
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgImageView];
        
        CGFloat scrollOriginY = [SDBaseView navBarHeight];
        _calScrollView = [[INRiliCalScrollView alloc] initWithFrame:CGRectMake(0.0, scrollOriginY, kScreenWidth, kScreenHeight - scrollOriginY)];
        _calScrollView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
        __weak typeof(self) weakSelf = self;
        _calScrollView.calHeaderView.updateDateBlock = ^(NSDate *showDate) {
            [weakSelf updateNavShowDate:showDate];
        };
        [self addSubview:_calScrollView];
        
        _calWeekView = [[INRiliCalWeekView alloc] initWithFrame:CGRectZero];
        _calWeekView.backgroundColor = [UIColor colorWithHexString:@"fc3f51"];
        _calWeekView.alpha = 0.0;
        //[self addSubview:_calWeekView];
        
        self.calScrollView.offsetBlock = ^(CGPoint offset) {
            if (offset.y > weakSelf.calScrollView.headerHeight/2) {
                weakSelf.calWeekView.alpha = 1;
            } else {
                weakSelf.calWeekView.alpha = 0;
            }
        };

//        [self bringSubviewToFront:self.systemNavBar];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat calHeight = CGRectGetWidth(self.bounds);
    self.bgImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    self.calWeekView.frame = CGRectMake(0.0, kStatusBarHeight+44.0, calHeight, kRiliCalWeekHeight);
    
    self.calScrollView.frame = CGRectMake(0.0, kStatusBarHeight+44.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - (kStatusBarHeight+44.0));
}

- (void)setDelegate:(id)delegate {
    _delegate = delegate;
    self.calScrollView.subDelegate = _delegate;
}

- (void)updateNavShowDate:(NSDate *)date {
    if (self.theDelegate && [self.theDelegate respondsToSelector:@selector(updateNavDidShowDate:)]) {
        [self.theDelegate updateNavDidShowDate:date];
    }
}

@end
