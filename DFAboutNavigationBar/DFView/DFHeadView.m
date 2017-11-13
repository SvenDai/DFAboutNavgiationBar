//
//  DFHeadView.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/13.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFHeadView.h"

@interface DFHeadView()

@end

@implementation DFHeadView

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI{
    [self addSubview:self.headImageView];
    [self makeViewConstraints];
}

- (void) makeViewConstraints{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading);
        make.top.equalTo(self.mas_top).offset(10.0);
        make.width.height.mas_equalTo(64);
    }];
}

#pragma mark - getter
-(UIImageView*) headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius   = 64 / 2.0;
        _headImageView.layer.masksToBounds  = YES;
        _headImageView.layer.anchorPoint    = CGPointMake(0.5, 0.5);
        
        _headImageView.backgroundColor = [UIColor redColor];
    }
    return _headImageView;
}

@end
