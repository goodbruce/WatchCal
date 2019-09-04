//
//  INRiliCalViewController.m
//  Shundan
//
//  Created by guobingwei on 2017/6/3.
//  Copyright © 2017年 Shundan. All rights reserved.
//

#import "INRiliCalViewController.h"
#import "INRiliCalView.h"
#import "INRiliCalPresenter.h"

@interface INRiliCalViewController ()<INRiliCalPresenterDelegate>

@property (nonatomic, strong) INRiliCalView *calView;
@property (nonatomic, strong) INRiliCalPresenter *calPresenter;
@property (nonatomic, strong) INRiliCalInteractor *calInteractor;

@end

@implementation INRiliCalViewController

- (void)leftNavBarButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

//#pragma mark - Configure NavigationBar
//- (void)configureNavigationBar {
//    SDNavButtonItem *leftButtonItem = [[SDNavButtonItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"ic_nav_back"] target:self action:@selector(leftNavBarButtonAction)];
//
//    SDNavButtonItem *rightButtonItem = [[SDNavButtonItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"ic_nav_rilical_today"] target:self action:@selector(rightNavBarButtonAction)];
//
//    self.calView.systemNavBar.navTitleView = [[SDNavigationTitleView alloc] initWidthTitle:@"      " subView:nil];
//    self.calView.systemNavBar.leftNavItem = leftButtonItem;
//    self.calView.systemNavBar.rightNavItem = rightButtonItem;
//    self.calView.systemNavBar.navTitleView.titleFont = UISYSFontSize(22);
//    NSString *curYearMonth = [SDCalculationUtil yearMonthFormatter:[NSDate date]];
//    [self updateNavigationTitle:curYearMonth];
//    [self.calView.systemNavBar layoutSubviews];
//}
//
//- (void)updateNavigationTitle:(NSString *)showYearMonth {
//    if (showYearMonth && showYearMonth.length > 0) {
//        showYearMonth = [showYearMonth stringByReplacingOccurrencesOfString:@"-" withString:@"."];
//    }
//    self.calView.systemNavBar.navTitleView.navTitle = (showYearMonth?showYearMonth:@"");
//}

- (void)rightNavBarButtonAction {
    [self.calPresenter rebackTodayMonth];
}

#pragma mark - loadView
- (void)loadView {
    [super loadView];
    self.view = self.calView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self configureNavigationBar];
    [self configureAssociation];
    
//    DLog(@"params:%@",self.params);
    [self.calPresenter loadCurrentDate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - Configure
- (void)configureAssociation {
    self.calPresenter.calView = self.calView;
    self.calView.delegate = self.calPresenter;
    self.calView.theDelegate = self.calPresenter;
    self.calPresenter.calInteractor = self.calInteractor;
    self.calPresenter.delegate = self;
    self.calPresenter.controller = self;
    
    //配置block handler传递
    //pop操作
//    __weak typeof(self) weakSelf = self;
//    self.calPresenter.popControllerHandler = ^(id data, BOOL popRootController) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if (popRootController) {
//            [strongSelf.navigationController popToRootViewControllerAnimated:YES];
//        } else {
//            [strongSelf.navigationController popViewControllerAnimated:YES];
//        }
//    };
//    
//    //dismiss操作
//    self.calPresenter.dismissControllerHandler = ^(id data) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        [strongSelf dismissViewControllerAnimated:YES completion:nil];
//    };
//    
//    //更新数据
//    self.calPresenter.controllerReloadHandler = ^(id data, NSString *identifier) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//    };
//    
//    //更新数据
//    self.calPresenter.controllerReloadHandler = ^(id data, NSString *identifier) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if ([kUpdateNavigationTitleIdentifier isEqualToString:identifier]) {
//            [strongSelf updateNavigationTitle:data];
//        }
//    };
}

#pragma mark - SETTER/GETTER
- (INRiliCalView *)calView {
    if (!_calView) {
        _calView = [[INRiliCalView alloc] initWithFrame:CGRectZero];
    }
    return _calView;
}

- (INRiliCalPresenter *)calPresenter {
    if (!_calPresenter) {
        _calPresenter = [[INRiliCalPresenter alloc] init];
    }
    return _calPresenter;
}

- (INRiliCalInteractor *)calInteractor {
    if (!_calInteractor) {
        _calInteractor = [[INRiliCalInteractor alloc] init];
    }
    return _calInteractor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
