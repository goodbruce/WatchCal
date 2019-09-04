//
//  INRiliCalInteractor.h
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INRiliCalDayItemViewModel.h"
#import "SDSystemDefine.h"

@interface INRiliCalInteractor : NSObject

@property (nonatomic, strong) INRiliCalDayItemViewModel *calDayItemViewModel;

@property (nonatomic, strong) NSMutableArray *monthDates;

@property (nonatomic, strong) NSMutableArray *dayDiarySouces;

@end
