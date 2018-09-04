//
//  HFTabBarController.m
//  HFCustomTabbarDemo
//
//  Created by HF on 2018/9/4.
//  Copyright © 2018年 HF. All rights reserved.
//

#import "HFTabBarController.h"
#import "FIRTabbar.h"


@interface HFTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIViewController *homeVC;
@property (nonatomic, strong) UIViewController *homeVC1;
@property (nonatomic, strong) UIViewController *mineVC;
@property (nonatomic, strong) FIRTabbar *tabbar;

@end

@implementation HFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.tabbar = [[FIRTabbar alloc]init];
    [self setValue:self.tabbar forKey:@"tabBar"];
    
    // 修改分割线颜色 shadowImage和backgroundImage 缺一不可
    CGSize size = CGSizeMake(kScreenWidth, 1.f/ [UIScreen mainScreen].scale);
    UIImage *lineImg = [UIImage imageWithColor:[UIColor colorWithHexString:@"line_e5"] size:size];
    [self.tabBar setShadowImage:lineImg];
    UIImage *bgImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"line_e5"]];
    [self.tabBar setBackgroundImage:bgImage];
    
    [self initTabBarViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    if (tabbarBottomPadding > 0) return ;
    //这里70 是自定义了tabbar的高度
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is your TabBar
    tabFrame.size.height = 70;
    tabFrame.origin.y = kScreenHeight - 70;
    self.tabBar.frame = tabFrame;
}

#pragma mark - public

+ (CGFloat)getTabbarHeight
{
    return tabbarHeight;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController *vc = viewController.viewControllers.firstObject;
    NSInteger tag = vc.tabBarItem.tag;
    [self.tabbar changeTargetViewAtIndex:tag] ;
    NSLog(@"点击了 第 %ld 个 tab",tag);
}

#pragma mark - private

- (void)initTabBarViewController
{
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:self.homeVC1];
    
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:self.mineVC];
    
    self.viewControllers = [NSArray arrayWithObjects:nav0,nav1,nav2,nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0f],NSFontAttributeName, [UIColor  colorWithHexString:@"999999"], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11.0f],NSFontAttributeName, [UIColor  blueColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    //初始化默认选项
    self.selectedIndex = HFTabbarItemTypeChart;//
    [self.tabbar changeTargetViewAtIndex:HFTabbarItemTypeChart] ;
    self.delegate = self;
}

#pragma mark - getter setter

- (UIViewController *)homeVC
{
    if (!_homeVC) {
        _homeVC = [[UIViewController alloc]init];
        NSString *title = nil;
        _homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:@""] selectedImage:nil];
        _homeVC.tabBarItem.tag = 0;
    }
    return _homeVC;
}

- (UIViewController *)homeVC1
{
    if (!_homeVC1) {
        _homeVC1 = [[UIViewController alloc]init];
        NSString *title = nil;
        _homeVC1.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:@""] selectedImage:nil];
        _homeVC1.tabBarItem.tag = 1;
        _homeVC1.view.backgroundColor = [UIColor yellowColor];
    }
    return _homeVC1;
}

- (UIViewController *)mineVC
{
    if (!_mineVC) {
        _mineVC = [[UIViewController alloc]init];
        NSString *title = nil;
        _mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil selectedImage:nil];
        _mineVC.tabBarItem.tag = 2;
        _mineVC.view.backgroundColor = [UIColor redColor];
    }
    return _mineVC;
}
@end
