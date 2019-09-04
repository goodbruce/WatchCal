//
//  INRiliCalPresenter.h
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INRiliCalView.h"
#import "INRiliCalInteractor.h"

@protocol INRiliCalPresenterDelegate;
@interface INRiliCalPresenter : NSObject <INRiliCalViewDelegate>

@property (nonatomic, weak) id<INRiliCalPresenterDelegate>delegate;
@property (nonatomic, strong) INRiliCalView *calView;
@property (nonatomic, strong) INRiliCalInteractor *calInteractor;
@property (nonatomic, weak) UIViewController *controller;

- (void)loadCurrentDate;
- (void)rebackTodayMonth;

@end

@protocol INRiliCalPresenterDelegate <NSObject>

- (void)calPresenterRouter:(NSString *)mark data:(id)data;

@end
