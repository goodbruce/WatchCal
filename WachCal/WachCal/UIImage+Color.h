//
//  UIImage+Color.h
//  BruceGuo
//
//  Created by BruceGuo on 2018/07/6.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 由Color生成的图片

 @param color 颜色
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 由Color生成的图片

 @param color 颜色
 @param size 大小
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 使用blend改变图片颜色

 @param tintColor tintColor
 @return image
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**
 使用blend改变图片颜色,kCGBlendModeOverlay
 
 @param tintColor tintColor
 @return image
 */
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

/**
 使用blend改变图片颜色

 @param tintColor tintColor
 @param blendMode mode
 @return image
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;

@end
