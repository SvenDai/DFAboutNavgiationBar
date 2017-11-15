//
//  DFTransparentBarHeadView.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/15.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFTransparentBarHeadView.h"

@implementation DFTransparentBarHeadView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) setupUI{
    [self addSubview:self.headImageView];
    [self setViewConstraints];
}

-(void) setViewConstraints{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(64);
    }];
}
#pragma mark - getter

-(UIImageView*) headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.layer.cornerRadius = 64 / 2.0;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

@end
