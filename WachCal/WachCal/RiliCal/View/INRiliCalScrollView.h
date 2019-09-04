//
//  INRiliCalScrollView.h
//  ticdiary
//
//  Created by guobingwei on 2019/1/7.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INRiliCalHeaderView.h"
#import "INRiliCalWeekView.h"

typedef void(^INRiliCalOffsetBlock)(CGPoint offset);

@interface INRiliCalScrollView : UIScrollView

@property (nonatomic, copy) INRiliCalOffsetBlock offsetBlock;

@property (nonatomic, strong) INRiliCalHeaderView *calHeaderView;

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, weak) id subDelegate;

@property (nonatomic, assign) CGFloat headerHeight;

@end
