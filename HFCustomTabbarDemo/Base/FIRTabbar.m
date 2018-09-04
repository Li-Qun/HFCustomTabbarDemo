//
//  FIRTabbar.m
//  HFCustomTabbarDemo
//
//  Created by HF on 2018/9/4.
//  Copyright © 2018年 HF. All rights reserved.
//

#import "FIRTabbar.h"
#import "FIRBarView.h"

@interface FIRTabbar ()

@property (nonatomic, strong) FIRBarView *customBarView;

@end

@implementation FIRTabbar

- (instancetype)init {
    self = [super init];
    if (!self)  return nil;
    
    self.customBarView = [[FIRBarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    [self addSubview:self.customBarView];
    
    [self addObserver:self forKeyPath:@"hidden"     options:NSKeyValueObservingOptionNew context:nil];
    
    return self;
}

#pragma mark - 对象被销毁

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"hidden"];
}

#pragma mark -- kvo 监听 只要观察对象属性有新值就会调用

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"hidden"]) {
        self.customBarView.hidden = self.hidden;
    }
}

- (void)changeTargetViewAtIndex:(NSInteger)index
{
    [self.customBarView updateTargetViewAtIndex:index];
}


@end
