//
//  INRiliCalScrollView.m
//  ticdiary
//
//  Created by guobingwei on 2019/1/7.
//  Copyright © 2019年 guobingwei. All rights reserved.
//

#import "INRiliCalScrollView.h"

static CGFloat kCalOffset = 30.0;

@interface INRiliCalScrollView ()<UIScrollViewDelegate>

@end

@implementation INRiliCalScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        //self.pagingEnabled = YES;
        
        CGFloat height = (kScreenHeight - [SDBaseView baseSafeEdgeInsets].bottom - [SDBaseView baseSafeEdgeInsets].top - 49.0)/2 + 40.0;
        self.headerHeight = height;

        [self addSubview:self.calHeaderView];
        [self addSubview:self.contentTableView];

        [self addObserver];
        [self.contentTableView reloadData];
    }
    return self;
}

- (void)setSubDelegate:(id)subDelegate {
    _subDelegate = subDelegate;
    self.calHeaderView.subDelegate = _subDelegate;
    self.contentTableView.dataSource = _subDelegate;
    self.contentTableView.delegate = _subDelegate;
}

- (void)updateContentSize {
    CGSize tablecontentSize = self.contentTableView.contentSize;
    
    CGFloat headerHeight = CGRectGetHeight(self.calHeaderView.frame);
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.bounds), headerHeight + ceil(tablecontentSize.height));
    self.contentSize = contentSize;
}

- (void)updateContentFrame {
    CGSize tablecontentSize = self.contentTableView.contentSize;
    CGFloat headerHeight = CGRectGetHeight(self.calHeaderView.frame);
//    self.contentTableView.height = tablecontentSize.height + headerHeight;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark KVO Refresh
- (void)addObserver {
    
//    __weak typeof(self) weakSelf = self;
//    [self.KVOController observe:self.contentTableView keyPath:@"contentSize" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        if ([change objectForKey:NSKeyValueChangeNewKey]) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf updateContentSize];
//        }
//    }];
//
//    [self.contentTableView.KVOController observe:self.contentTableView keyPath:@"contentSize" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
//        if ([change objectForKey:NSKeyValueChangeNewKey]) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            [strongSelf updateContentFrame];
//        }
//    }];
}

- (void)removeObserver{
//    [self.KVOController unobserveAll];
}

#pragma mark - SETTER/GETTER
- (INRiliCalHeaderView *)calHeaderView {
    if (!_calHeaderView) {
        _calHeaderView = [[INRiliCalHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, self.headerHeight)];
        _calHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _calHeaderView;
}

- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, self.headerHeight, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _contentTableView.backgroundColor = [UIColor colorWithHexString:@"eff1f4"];
        _contentTableView.rowHeight = 50.0;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.scrollEnabled = NO;
    }
    return _contentTableView;
}

- (void)dealloc {
    [self removeObserver];
}


@end
