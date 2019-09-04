//
//  INRiliCalDiarySectionView.m
//  TicCal
//
//  Created by guobingwei on 2019/1/19.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "INRiliCalDiarySectionView.h"

@interface INRiliCalDiarySectionView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation INRiliCalDiarySectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
        [self addSubview:_backImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = UISYSFontSize(18);
        _titleLabel.textColor = [UIColor colorWithHexString:@"595959"];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"- 这一天共10篇日记 -";
        [self.backImageView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = self.bounds;
    self.titleLabel.frame = self.bounds;
}

- (void)setDiaryNumber:(NSString *)diaryNumber {
    _diaryNumber = diaryNumber;
}

@end
