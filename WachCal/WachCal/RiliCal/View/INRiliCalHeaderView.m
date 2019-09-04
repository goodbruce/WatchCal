//
//  INRiliCalHeaderView.m
//  ticdiary
//
//  Created by guobingwei on 2019/1/7.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "INRiliCalHeaderView.h"

static CGFloat kRiliCalHPadding = 10.0;
static CGFloat kRiliCalHSmallPadding = 0.0;

static CGFloat kWeekSectionHeight = 40.0;

static CGFloat startPointX = 0;

@interface INRiliCalHeaderView ()

@property (nonatomic) CGPoint panStartPoint;

@property (nonatomic, strong) INRiliCalMonthView *oneMonthView;
@property (nonatomic, strong) INRiliCalMonthView *twoMonthView;
@property (nonatomic, strong) INRiliCalMonthView *threeMonthView;

@property (nonatomic, assign) BOOL isLeftMove;

//当前显示的下标
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) UISwipeGestureRecognizer *recognizer;

@end

@implementation INRiliCalHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //中间显示是第二个 twoMonthView
        self.currentIndex = 2;
        self.isAnimationing = NO;
        self.clipsToBounds = YES;
        self.monthCards = [NSMutableArray arrayWithCapacity:0];
        
        _maskBGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _maskBGImageView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
        [self addSubview:_maskBGImageView];
        
        _weekBGImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _weekBGImageView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc" alpha:0.10];
        [self addSubview:_weekBGImageView];
        
        NSArray *arr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        for (int i = 0; i < 7; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 40, 35)];
            label.text = arr[i];
            label.backgroundColor = [UIColor clearColor];
            label.font = UISYSFontSize(14);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor colorWithHexString:@"565656"];
            [self.weekBGImageView addSubview:label];
            
            if (i == 5 || i == 6) {
                label.textColor = [UIColor colorWithHexString:@"ed3636"];
            }
        }
        
        [self reloadTodayData];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureHandle:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panGesture];
        
        if (self.updateDateBlock) {
            NSDate *date = [self getShowCurrentDate];
            self.updateDateBlock(date);
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.maskBGImageView.frame = CGRectMake(kRiliCalHPadding, kRiliCalHPadding, CGRectGetWidth(self.bounds) - 2*kRiliCalHPadding, CGRectGetHeight(self.bounds) - 2*kRiliCalHPadding);
    
    self.weekBGImageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), kWeekSectionHeight);
    
    CGFloat weekWidth = (CGRectGetWidth(self.weekBGImageView.frame) - 2*kRiliCalHPadding)/7;
    CGFloat weekHeight = CGRectGetHeight(self.weekBGImageView.frame);
    UILabel *lastLabel;
    for (UILabel *label in self.weekBGImageView.subviews) {
        label.frame = CGRectMake((lastLabel?CGRectGetMaxX(lastLabel.frame):kRiliCalHPadding), 0.0, weekWidth, weekHeight);
        lastLabel = label;
    }
    
    CGFloat cardWidth = CGRectGetWidth(self.bounds);
    CGFloat cardHeight = CGRectGetWidth(self.bounds) - 2*(kRiliCalHPadding + kRiliCalHSmallPadding) - CGRectGetMaxY(self.weekBGImageView.frame);
    
//    CGFloat cardOriginX = kRiliCalHPadding + kRiliCalHSmallPadding;
//    CGFloat cardOriginY = kRiliCalHPadding + kRiliCalHSmallPadding;
    CGFloat cardOriginX = 0.0;
    CGFloat cardOriginY = CGRectGetMaxY(self.weekBGImageView.frame);

//    for (INRiliCalMonthView *monthView in self.monthCards) {
//        NSInteger index = monthView.tag;
//        monthView.frame = CGRectMake(cardOriginX + cardWidth*(index - 1), cardOriginY, cardWidth, cardHeight);
//    }
    
    self.oneMonthView.frame = CGRectMake(-cardWidth, cardOriginY, cardWidth, cardHeight);
    self.twoMonthView.frame = CGRectMake(0, cardOriginY, cardWidth, cardHeight);
    self.threeMonthView.frame = CGRectMake(cardWidth, cardOriginY, cardWidth, cardHeight);
}

- (void)setSubDelegate:(id)subDelegate {
    _subDelegate = subDelegate;
    
    self.oneMonthView.monthDelegate = _subDelegate;
    self.twoMonthView.monthDelegate = _subDelegate;
    self.threeMonthView.monthDelegate = _subDelegate;
}


//回到当前月份
- (void)reloadTodayData {
    [self.monthCards removeAllObjects];
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[INRiliCalMonthView class]]) {
//            [subView removeAllSubviews];
        }
    }
    
    self.currentIndex = 2;
    
    self.oneMonthView = nil;
    self.twoMonthView = nil;
    self.threeMonthView = nil;

    NSDate *currentDate = [NSDate date];
    NSDate *preDate = [SDCalculationUtil getDateOfLastMonth:currentDate];
    NSDate *nextDate = [SDCalculationUtil getDateOfNextMonth:currentDate];
    
    for (NSInteger index = 0; index < 3; index++) {
        INRiliCalMonthView *monthView = [[INRiliCalMonthView alloc] initWithFrame:CGRectZero];
        monthView.tag = index;
        [self.monthCards addObject:monthView];
        if (index == 0) {
            monthView.monthDate = preDate;
            monthView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc" alpha:0.05];
            self.oneMonthView = monthView;
        } else if (index == 1) {
            monthView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc" alpha:0.05];
            monthView.monthDate = currentDate;
            self.twoMonthView = monthView;
        } else if (index == 2) {
            monthView.monthDate = nextDate;
            monthView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc" alpha:0.05];
            self.threeMonthView = monthView;
        }
        [self addSubview:monthView];
    }
    
    self.oneMonthView.monthDelegate = self.subDelegate;
    self.twoMonthView.monthDelegate = self.subDelegate;
    self.threeMonthView.monthDelegate = self.subDelegate;
    
    if (self.updateDateBlock) {
        NSDate *date = [self getShowCurrentDate];
        self.updateDateBlock(date);
    }
    
    [self setNeedsLayout];
}

#pragma mark - Set方法
-(void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
//    
//    CGFloat alpha = 0;
//    if (contentOffsetY > 70) {
//        alpha = 0;
//    } else if (contentOffsetY > 20) {
//        alpha = (70 - contentOffsetY) / 50;
//    } else {
//        alpha = 1;
//    }
//    
//    for (UIView *subview in self.subviews) {
//        subview.alpha = alpha;
//    }
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)recognizer{
//    if (self.isAnimationing) {
//        return;
//    }
    
    CGPoint point = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (self.isAnimationing) {
            return;
        }
        startPointX = point.x;
        self.isAnimationing = YES;
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self showMonthFrame:point.x startPointX:startPointX];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self stopMove:startPointX point:point];
    }
}

- (void)showMonthFrame:(CGFloat)x startPointX:(CGFloat)startPointX {
    BOOL isLeft = YES;
    CGFloat offsetX = x - startPointX;
    if (startPointX - x > 0) {
        //向左移动
        isLeft = YES;
        offsetX = startPointX - x;
    } else {
        //向右移动
        isLeft = NO;
        offsetX = x - startPointX;
    }
    
    CGRect oneFrame = self.oneMonthView.frame;
    CGRect twoFrame = self.twoMonthView.frame;
    CGRect threeFrame = self.threeMonthView.frame;
    if (self.currentIndex == 2) {
        if (isLeft) {
//            twoFrame.origin.x = -self.width;
//            threeFrame.origin.x = 0;
            twoFrame.origin.x = 0 - offsetX;
            threeFrame.origin.x = self.width - offsetX;
        } else {
//            twoFrame.origin.x = self.width;
//            oneFrame.origin.x = 0;
            twoFrame.origin.x = offsetX;
            oneFrame.origin.x = -self.width + offsetX;
        }
    } else if (self.currentIndex == 3) {
        if (isLeft) {
//            oneFrame.origin.x = 0;
//            threeFrame.origin.x = -self.width;
            oneFrame.origin.x = self.width - offsetX;
            threeFrame.origin.x = 0 - offsetX;
        } else {
//            twoFrame.origin.x = 0;
//            threeFrame.origin.x = self.width;
            twoFrame.origin.x = -self.width + offsetX;
            threeFrame.origin.x = offsetX;
        }
    } else if (self.currentIndex == 1) {
        if (isLeft) {
//            twoFrame.origin.x = self.width;
//            oneFrame.origin.x = -self.width;
            twoFrame.origin.x = self.width - offsetX;
            oneFrame.origin.x = 0 - offsetX;
        } else {
//            threeFrame.origin.x = 0;
//            oneFrame.origin.x = self.width;
            threeFrame.origin.x = -self.width+offsetX;
            oneFrame.origin.x = offsetX;
        }
    }
    
    self.oneMonthView.frame = oneFrame;
    self.twoMonthView.frame = twoFrame;
    self.threeMonthView.frame = threeFrame;
}

- (void)stopMove:(CGFloat)startPointX point:(CGPoint)point {
    
    BOOL isLeft = YES;
    if (startPointX - point.x > 0) {
        //向左移动
        isLeft = YES;
    } else {
        //向右移动
        isLeft = NO;
    }

    CGRect oneFrame = self.oneMonthView.frame;
    CGRect twoFrame = self.twoMonthView.frame;
    CGRect threeFrame = self.threeMonthView.frame;
    if (self.currentIndex == 2) {
        if (isLeft) {
            twoFrame.origin.x = -self.width;
            threeFrame.origin.x = 0;
        } else {
            twoFrame.origin.x = self.width;
            oneFrame.origin.x = 0;
        }
    } else if (self.currentIndex == 3) {
        if (isLeft) {
            oneFrame.origin.x = 0;
            threeFrame.origin.x = -self.width;
        } else {
            twoFrame.origin.x = 0;
            threeFrame.origin.x = self.width;
        }
    } else if (self.currentIndex == 1) {
        if (isLeft) {
            twoFrame.origin.x = 0;
            oneFrame.origin.x = -self.width;
        } else {
            threeFrame.origin.x = 0;
            oneFrame.origin.x = self.width;
        }
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.oneMonthView.frame = oneFrame;
        self.twoMonthView.frame = twoFrame;
        self.threeMonthView.frame = threeFrame;
    } completion:^(BOOL finished) {
        self.isAnimationing = NO;
        if (isLeft) {
            //向左移动
            if (self.currentIndex == 2) {
                self.currentIndex = 3;
                CGRect oneFrame = self.oneMonthView.frame;
                oneFrame.origin.x = self.width;
                self.oneMonthView.frame = oneFrame;
                
                //获取数据
                NSDate *oneDate = [SDCalculationUtil getDateOfNextMonth:self.threeMonthView.monthDate];
                self.oneMonthView.monthDate = oneDate;
                
            } else if (self.currentIndex == 3) {
                self.currentIndex = 1;
                CGRect twoFrame = self.twoMonthView.frame;
                twoFrame.origin.x = self.width;
                self.twoMonthView.frame = twoFrame;
                
                //获取数据
                NSDate *twoDate = [SDCalculationUtil getDateOfNextMonth:self.oneMonthView.monthDate];
                self.twoMonthView.monthDate = twoDate;
                
            } else if (self.currentIndex == 1) {
                self.currentIndex = 2;
                CGRect threeFrame = self.threeMonthView.frame;
                threeFrame.origin.x = self.width;
                self.threeMonthView.frame = threeFrame;
                
                //获取数据
                NSDate *threeDate = [SDCalculationUtil getDateOfNextMonth:self.twoMonthView.monthDate];
                self.threeMonthView.monthDate = threeDate;
            }
        } else {
            //向右移动
            if (self.currentIndex == 2) {
                self.currentIndex = 1;
                CGRect threeFrame = self.threeMonthView.frame;
                threeFrame.origin.x = -threeFrame.size.width;
                self.threeMonthView.frame = threeFrame;
                
                //获取数据
                NSDate *threeDate = [SDCalculationUtil getDateOfLastMonth:self.oneMonthView.monthDate];
                self.threeMonthView.monthDate = threeDate;
                
            } else if (self.currentIndex == 3) {
                self.currentIndex = 2;
                CGRect oneFrame = self.oneMonthView.frame;
                oneFrame.origin.x = -oneFrame.size.width;
                self.oneMonthView.frame = oneFrame;
                
                //获取数据
                NSDate *oneDate = [SDCalculationUtil getDateOfLastMonth:self.twoMonthView.monthDate];
                self.oneMonthView.monthDate = oneDate;
                
            } else if (self.currentIndex == 1) {
                self.currentIndex = 3;
                CGRect twoFrame = self.twoMonthView.frame;
                twoFrame.origin.x = -twoFrame.size.width;
                self.twoMonthView.frame = twoFrame;
                
                //获取数据
                NSDate *twoDate = [SDCalculationUtil getDateOfLastMonth:self.threeMonthView.monthDate];
                self.twoMonthView.monthDate = twoDate;
            }
        }
        
        if (self.updateDateBlock) {
            NSDate *date = [self getShowCurrentDate];
            self.updateDateBlock(date);
        }
    }];
}

/**
 获取当前显示的数据

 @return date
 */
- (NSDate *)getShowCurrentDate {
    if (self.currentIndex == 1) {
        return self.oneMonthView.monthDate;
    } else if (self.currentIndex == 2) {
        return self.twoMonthView.monthDate;
    } else {
        return self.threeMonthView.monthDate;
    }
}

//标记当前显示的月的day显示为选中状态
- (void)markSelectedStatus:(NSString *)yearMonthDay {
    if (self.currentIndex == 1) {
        [self.oneMonthView markSelectedStatus:yearMonthDay];
    } else if (self.currentIndex == 2) {
        [self.twoMonthView markSelectedStatus:yearMonthDay];
    } else {
        [self.threeMonthView markSelectedStatus:yearMonthDay];
    }
}

@end
