//
//  ZPAdLaunchImageV.m
//  OLaunchNetEase
//
//  Created by WangZhipeng on 15/12/11.
//  Copyright © 2015年 WangZhipeng. All rights reserved.
//

#import "ZPAdLaunchImageV.h"

@interface ZPAdLaunchImageV ()

@property (nonatomic, weak) UIImageView *adImageView;

@end

@implementation ZPAdLaunchImageV

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addAdImageView];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        [self addAdImageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addAdImageView {
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    _adImageView = imageView;
}

- (void)setURLString:(NSString *)URLString {
    _URLString = URLString;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 异步操作
        // 从网络上下载图片，只是个demo 并不建议这么做
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
        if (!data) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程更新
            _adImageView.alpha = 0.0;
            _adImageView.image = [UIImage imageWithData:data];
//            [UIView animateWithDuration:0.3 animations:^{
//                _adImageView.alpha = 1.0;
//            }];
            [UIView animateWithDuration:0.3
                                  delay:0.6
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                _adImageView.alpha = 1.0;
            } completion:nil];
        });
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _adImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.78);
}

@end
