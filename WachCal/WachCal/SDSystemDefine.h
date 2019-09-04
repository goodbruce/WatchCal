//
//  SDSystemDefine.h
//  BruceGuo
//
//  Created by BruceGuo on 2018/7/29.
//  Copyright © 2018年 BruceGuo. All rights reserved.
//

#ifndef SDSystemDefine_h
#define SDSystemDefine_h

#import "SDFontDefine.h"

//屏幕宽度和高度
#define kStatusBarHeight CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame])
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kScreenWidthScale   kScreenWidth / 320

#define kSysTabbarHeight   49.0

//Appdelegate宏定义
#define KAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

//判读设备
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//info.plist文件版本信息数据
#define    BUILDVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define    SHORTVERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define    BUILDCOUNT [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleGetInfoString"]
#define    APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define ChANNELID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"ChannelID"]

//设备版本信息
#define OS_VERSION [[UIDevice currentDevice] systemVersion]
#define DEVICE_ID [[UIDevice currentDevice] identifierForVendor]
#define DEVICE_MODEL [[UIDevice currentDevice] modelName]

//版本识别宏
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//系统版本号判断
#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define ISIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define ISIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define ISIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define ISIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

//本地Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒temp路径
#define kTempPath NSTemporaryDirectory()

//获取沙盒Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//设置需要粘贴的文字或图片
#define SDPasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define SDPasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];

//log打印
#ifdef DEBUG
#define DLog(format, ...) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format),  ##__VA_ARGS__] )
#else
#define DLog(...)
#endif

//打印Frame
#ifdef DEBUG
#define DLogFrame(frame) NSLog( @"<%@:(%d)> frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, frame.origin.x,frame.origin.y,frame.size.width,frame.size.height)
#else
#define DLogFrame(...)
#endif

//打印Point
#ifdef DEBUG
#define DLogPoint(point) NSLog( @"<%@:(%d)> Point[X=%.1f,Y=%.1f]", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, point.x,point.y)
#else
#define DLogPoint(...)
#endif

//多线程处理信号量，类中有    dispatch_semaphore_t _lock;变量
#define SDINIT(...) self = super.init; \
if (!self) return nil; \
__VA_ARGS__; \
if (!_dic) return nil; \
_lock = dispatch_semaphore_create(1); \
return self;


#define SDLOCK(...) dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER); \
__VA_ARGS__; \
dispatch_semaphore_signal(_lock);

//控制台打印log
#ifdef DEBUG
#define DebugLog(format, ...) NSLog( @"<%@:(%d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(format),  ##__VA_ARGS__] )
#else
#define DebugLog(...)
#endif

//dispatch
#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


//弱引用/强引用
#define SDWeakify(var) __weak typeof(var) SDKWeak_##var = var;
#define SDStrongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = SDKWeak_##var; \
_Pragma("clang diagnostic pop")

#endif /* SDSystemDefine_h */
