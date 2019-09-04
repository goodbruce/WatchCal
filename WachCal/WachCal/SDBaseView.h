//
//  SDBaseView.h
//  BruceGuo
//
//  Created by BruceGuo on 2018/07/9.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"
#import "SDSystemDefine.h"

@interface SDBaseView : UIView

@property (nonatomic, assign) CGFloat safeInsetBottom;

+ (UIEdgeInsets)baseSafeEdgeInsets;

+ (CGFloat)navBarHeight;

+ (CGFloat)tabbarHeight;

//返回imageView在window上全屏显示时的frame
+ (CGRect)backScreenImageViewRectWithImage:(UIImage *)image;

@end
