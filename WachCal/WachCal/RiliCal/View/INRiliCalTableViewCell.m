//
//  INRiliCalTableViewCell.m
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "INRiliCalTableViewCell.h"
#import "UIColor+Addition.h"
#import "UIImage+Color.h"
#import "NSString+Size.h"
#import "SDFontDefine.h"

static CGFloat kHTitlePadding = 15.0f;

static CGFloat kCellSmallPadding = 5.0f;
static CGFloat kProfileIconSize = 20.0f;
static CGFloat kVTitleHeight = 30.0f;
static CGFloat kVContentHeight = 50.0f;

static CGFloat kArrowSizeWidth = 15.0;
static CGFloat kArrowSizeHeight = 20.0;

static CGFloat kMarkTagSize = 30.0;

@interface INRiliCalTableViewCell ()


@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *tagImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation INRiliCalTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backImageView.userInteractionEnabled = YES;
        _backImageView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
        _backImageView.layer.cornerRadius = 4;
        _backImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_backImageView];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.userInteractionEnabled = YES;
        [self.backImageView addSubview:_iconImageView];
        
        _tagImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _tagImageView.userInteractionEnabled = YES;
        _tagImageView.image = [[UIImage imageNamed:@"ic_router_line_selected"] imageWithTintColor:[UIColor colorWithHexString:@"59493f" alpha:0.5]];
        _tagImageView.hidden = YES;
        [self.backImageView addSubview:_tagImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = UISYSFontSize(20);
        _titleLabel.textColor = [UIColor colorWithHexString:@"585858"];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.backImageView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = UISYSFontSize(16);
        _contentLabel.textColor = [UIColor colorWithHexString:@"898989"];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.backImageView addSubview:_contentLabel];
        
        NSArray *imagesArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"ic_cal_arrow_1"],
                               [UIImage imageNamed:@"ic_cal_arrow_2"],
                               [UIImage imageNamed:@"ic_cal_arrow_3"],
                               [UIImage imageNamed:@"ic_cal_arrow_4"],
                               [UIImage imageNamed:@"ic_cal_arrow_5"],
                               [UIImage imageNamed:@"ic_cal_arrow_6"],
                               [UIImage imageNamed:@"ic_cal_arrow_7"],
                               [UIImage imageNamed:@"ic_cal_arrow_8"],nil];
        
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _arrowImageView.userInteractionEnabled = YES;
        _arrowImageView.animationImages = imagesArray;//将序列帧数组赋给UIImageView的animationImages属性
        _arrowImageView.animationDuration = 1.0;//设置动画时间
        _arrowImageView.animationRepeatCount = 0;//设置动画次数 0 表示无限
        _arrowImageView.hidden = YES;
        [self.backImageView addSubview:_arrowImageView];
        [_arrowImageView startAnimating];//开始播放动画
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backImageView.frame = CGRectMake(kCellSmallPadding, kCellSmallPadding, CGRectGetWidth(self.bounds) - 2*kCellSmallPadding, CGRectGetHeight(self.bounds) - 2*kCellSmallPadding);
    
    self.tagImageView.frame = CGRectMake(CGRectGetWidth(self.backImageView.frame)-kMarkTagSize, 0.0, kMarkTagSize, kMarkTagSize);
    
    CGFloat iconOriginX = self.iconImage?kHTitlePadding:0.0;
    CGFloat iconSize = self.iconImage?kProfileIconSize:0.0;
    
    self.iconImageView.frame = CGRectMake(kHTitlePadding, (CGRectGetHeight(self.backImageView.frame)-iconSize)/2, iconSize, iconSize);
    
    CGFloat contentOriginX = CGRectGetMaxX(self.iconImageView.frame)+kHTitlePadding;

    CGFloat contentMaxWidth = CGRectGetWidth(self.backImageView.frame) - contentOriginX - kHTitlePadding;
    
//    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(contentMaxWidth, kVTitleHeight)];
//    CGFloat titleHeight = ceil(titleSize.height) + 10.0;
    CGFloat titleHeight = 20.0 + 10.0;

//    CGSize contentSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font maxSize:CGSizeMake(contentMaxWidth, MAXFLOAT)];
//    CGFloat contentHeight = ceil(contentSize.height) + 10.0;
    CGFloat contentHeight = 44.0 + 10.0;

    CGFloat titleOriginY = (CGRectGetHeight(self.backImageView.frame) - titleHeight - contentHeight)/2;
    
    self.titleLabel.frame = CGRectMake(contentOriginX, titleOriginY, contentMaxWidth, titleHeight);
    
    self.contentLabel.frame = CGRectMake(contentOriginX, CGRectGetMaxY(self.titleLabel.frame), contentMaxWidth, contentHeight);
    
    self.arrowImageView.frame = CGRectMake((CGRectGetWidth(self.backImageView.frame) - kArrowSizeWidth)/2, CGRectGetHeight(self.backImageView.frame) - kArrowSizeHeight, kArrowSizeWidth, kArrowSizeHeight);
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
    [self.arrowImageView startAnimating];//开始播放动画
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setIconImage:(UIImage *)iconImage {
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
    [self setNeedsLayout];
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    _tagImageView.image = [[UIImage imageNamed:@"ic_router_line_selected"] imageWithTintColor:maskColor];
}

- (void)setShowBottomArrow:(BOOL)showBottomArrow {
    _showBottomArrow = showBottomArrow;
    self.arrowImageView.hidden = !showBottomArrow;
    [self setNeedsLayout];
}

- (void)setShowMark:(BOOL)showMark {
    _showMark = showMark;
    self.tagImageView.hidden = !showMark;
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (highlighted) {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    } else {
        self.backImageView.backgroundColor = [UIColor colorWithHexString:@"fcfcfc"];
    }
}

- (void)dealloc {
    
}

@end
