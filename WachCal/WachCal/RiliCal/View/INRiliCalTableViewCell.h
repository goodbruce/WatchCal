//
//  INRiliCalTableViewCell.h
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "SDBaseTableViewCell.h"
#import "NSString+Size.h"

/**
 选择的日期的日历
 */
@protocol INRiliCalTableViewCellDelegate;
@interface INRiliCalTableViewCell : SDBaseTableViewCell

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, weak) id<INRiliCalTableViewCellDelegate>delegate;
@property (nonatomic, assign) BOOL showBottomArrow;
@property (nonatomic, assign) BOOL showMark;
@property (nonatomic, strong) UIColor *maskColor;

@end

@protocol INRiliCalTableViewCellDelegate <NSObject>

@end
