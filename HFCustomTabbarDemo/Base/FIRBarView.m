//
//  FIRBarView.m
//  HFCustomTabbarDemo
//
//  Created by HF on 2018/9/4.
//  Copyright © 2018年 HF. All rights reserved.
//

#import "FIRBarView.h"

@interface FIRBarView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *targetLabel;
@property (nonatomic, strong) NSArray *targetXArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation FIRBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
        self.backView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - private

- (void)configSubviews
{
    CGFloat blankPadding =  HorizontalFrom750(68);
    CGFloat btnWidth = round((kScreenWidth - blankPadding * 2) / 3);
    blankPadding = (kScreenWidth - btnWidth * 3) / 2;
    self.targetXArray = @[@(blankPadding + btnWidth / 2),@(blankPadding + btnWidth + btnWidth / 2),@(blankPadding + btnWidth * 2 + btnWidth / 2)];
    
    self.titleArray = @[@"钱包",@"行情",@"我的"];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(blankPadding);
        make.right.equalTo(self).offset(- blankPadding);
        make.height.equalTo(@(36));
        make.centerY.equalTo(self);
    }];
    
    UIColor *titleColor = [UIColor colorWithHexString:@"A9ABB2"];
    UIButton *lastBtn = nil;
    NSArray *array = self.titleArray;
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightLight]];
        
        [self.backView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right);
                make.top.bottom.height.equalTo(lastBtn);
                if (i == 1) {
                    make.width.equalTo(@(btnWidth));
                } else {
                    make.right.equalTo(self.backView);
                }
            } else {
                make.left.top.bottom.equalTo(self.backView);
                make.width.equalTo(@(btnWidth));
            }
        }];
        lastBtn = btn;
    }
    [self addSubview:self.targetLabel];
    
    self.targetLabel.width = btnWidth + 30;
    [self updateTargetViewAtIndex:0];
}

- (void)updateTargetViewAtIndex:(NSInteger)index
{
    if (index > 2) index = 2;
    if (index < 0) index = 0;
    
    self.targetLabel.text = self.titleArray[index];
    NSInteger num = [self.targetXArray[index] integerValue];
    //切换效果
    [UIView animateWithDuration:1.0 delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        self.targetLabel.centerX = num;
    }completion:^(BOOL finished){
        //NSLog(@"动画结束");
    }];
}

#pragma mark - getter setter

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.layer.cornerRadius = 36 / 2;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = [UIColor colorWithHexString:@"A9ABB2"].CGColor;
        _backView.layer.borderWidth = 1.0;
    }
    return _backView;
}

- (UILabel *)targetLabel
{
    if (!_targetLabel) {
        CGFloat height = 41;
        _targetLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (self.height - height)/2, HorizontalFrom750(80), height)];
        _targetLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        _targetLabel.textAlignment = NSTextAlignmentCenter;
        _targetLabel.textColor = [UIColor colorWithHexString:@"2B3C4D"] ;
        _targetLabel.layer.cornerRadius = (height) / 2;
        _targetLabel.layer.masksToBounds = YES;
        _targetLabel.layer.borderColor = _targetLabel.textColor.CGColor;
        _targetLabel.layer.borderWidth = 1.0;
        _targetLabel.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _targetLabel;
}

@end
