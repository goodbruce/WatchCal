//
//  INRiliCalView.h
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "SDBaseView.h"
#import "INRiliCalHeaderView.h"
#import "INRiliCalWeekView.h"
#import "INRiliCalScrollView.h"
#import "INRiliCalDiarySectionView.h"

@protocol INRiliCalViewDelegate;
@interface INRiliCalView : SDBaseView

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) id<INRiliCalViewDelegate>theDelegate;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) INRiliCalScrollView *calScrollView;

@property (nonatomic, strong) INRiliCalWeekView *calWeekView;

- (id)initWithFrame:(CGRect)frame;

@end

@protocol INRiliCalViewDelegate <NSObject>

- (void)updateNavDidShowDate:(NSDate *)date;

@end
