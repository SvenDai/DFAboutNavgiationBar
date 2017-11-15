//
//  DFHideBarViewController.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/10.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFHideBarViewController.h"

@interface DFHideBarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView     *tableView;

@end

@implementation DFHideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"隐藏";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.leading.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
-(UITableView*) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  20;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CELL";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [self randomColor];
    return cell;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    
    if (offsetY > 64) {
        if (panTranslationY > 0) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}
@end
