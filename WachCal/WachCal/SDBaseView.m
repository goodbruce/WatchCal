//
//  SDBaseView.m
//  BruceGuo
//
//  Created by BruceGuo on 2018/07/9.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#import "SDBaseView.h"

@implementation SDBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.safeInsetBottom = 0.0;
        if (ISIOS11) {
            if (@available(iOS 11.0, *)) {
                UIEdgeInsets safeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
                self.safeInsetBottom = safeInsets.bottom;
            } else {
                // Fallback on earlier versions
            }
        }
    }
    return self;
}

+ (UIEdgeInsets)baseSafeEdgeInsets {
    UIEdgeInsets aSafeEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    if (ISIOS11) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeInsets = [UIApplication sharedApplication].keyWindow.safeAreaInsets;
            aSafeEdgeInsets = safeInsets;
        } else {
            // Fallback on earlier versions
        }
    }
    return aSafeEdgeInsets;
}

+ (CGFloat)navBarHeight {
    return kStatusBarHeight+44.0;
}

+ (CGFloat)tabbarHeight {
    return 49.0 + [SDBaseView baseSafeEdgeInsets].bottom;
}

//返回imageView在window上全屏显示时的frame
+ (CGRect)backScreenImageViewRectWithImage:(UIImage *)image{
    if (image == nil) {
        return CGRectZero;
    }
    CGSize size = image.size;
    CGSize newSize;
    newSize.width = kScreenWidth;
    newSize.height = newSize.width / size.width * size.height;
    
    CGFloat imageY = (kScreenHeight - newSize.height) * 0.5;
    
    if (imageY < 0) {
        imageY = 0;
    }
    CGRect rect =  CGRectMake(0, imageY, newSize.width, newSize.height);
    
    return rect;
}

@end
