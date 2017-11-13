//
//  DFScaleViewController.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/10.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFScaleViewController.h"
#import "DFHeadView.h"

@interface DFScaleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) DFHeadView  *headView;

@property(nonatomic,assign) CGFloat     *reciveAlpha;

@end

@implementation DFScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"缩放";
    
    [self setupUI];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUI{
    [self.view addSubview:self.tableView];
    self.navigationItem.titleView = self.headView;
    [self makeViewConstraints];
}

-(void) makeViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self.view);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationItem.titleView);
        make.centerY.equalTo(self.navigationItem.titleView.mas_centerY);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(44);
    }];
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


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self.tableView.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f",offsetY);
    if (offsetY < 0 && offsetY >= -150) {
        self.headView.headImageView.transform = CGAffineTransformMakeScale(1+offsetY/(-300), 1+offsetY/(-300));
    }else if (offsetY >= 0 && offsetY <= 165){
        self.headView.headImageView.transform = CGAffineTransformMakeScale(1-offsetY/300, 1-offsetY/300);
    }else if (offsetY > 165){
        self.headView.headImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
    }else if (offsetY < -150){
        self.headView.headImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    }
    
    CGRect frame = self.headView.headImageView.frame;
    frame.origin.y = 5;
    self.headView.headImageView.frame = frame;
}

#pragma mark - private method
- (UIColor *) randomColor{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
}

#pragma mark - getter 

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        
        _tableView.backgroundColor  = [UIColor whiteColor];
        _tableView.separatorStyle   = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (DFHeadView*) headView{
    if (!_headView) {
        _headView = [[DFHeadView alloc] init];
        //_headView.backgroundColor = [UIColor blackColor];
    }
    return _headView;
}

@end
