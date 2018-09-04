//
//  HFTabBarController.h
//  HFCustomTabbarDemo
//
//  Created by HF on 2018/9/4.
//  Copyright © 2018年 HF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HFTabbarItemType) {
    HFTabbarItemTypeHome = 0,
    HFTabbarItemTypeChart,
    HFTabbarItemTypeMine
};

@interface HFTabBarController : UITabBarController


/**
 获取 app tabbar height
 
 @return tabbar height
 */
+ (CGFloat)getTabbarHeight;

@end
