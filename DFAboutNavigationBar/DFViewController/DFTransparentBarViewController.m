//
//  DFTransparentBarViewController.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/10.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFTransparentBarViewController.h"
#import "DFTransparentBarHeadView.h"

@interface DFTransparentBarViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView     *tableView;
@property(nonatomic,strong) UIImageView     *topImageView;
@property(nonatomic,strong) DFTransparentBarHeadView    *headView;

@property(nonatomic,assign) CGFloat         barAlpha;

@end

@implementation DFTransparentBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"透明";
    [self setupUI];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupUI{
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headView;
    [self.view insertSubview:self.topImageView belowSubview:self.tableView];
    [self setViewConstraints];
}

-(void) setViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.trailing.bottom.equalTo(self.view);

    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.tableView);
        make.bottom.mas_equalTo(-350);
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

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat topContentInset = 136;
    if (offsetY > 136 && offsetY <= 136*2) {
        if (offsetY/(topContentInset*2.0) >= 1) {
            self.barAlpha = 1;
        }else{
            _barAlpha = offsetY / (topContentInset * 2);
        }
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_barAlpha];
    }else if (offsetY <= 136){
        _barAlpha = 0;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_barAlpha];
    }else if(offsetY > 136*2){
        _barAlpha = 1;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_barAlpha];
    }
    
    if (offsetY < 0) {
        _topImageView.transform = CGAffineTransformMakeScale(1+ offsetY/(-500), 1+offsetY/(-500));
    }
    CGRect frame = _topImageView.frame;
    frame.origin.y = 0;
    _topImageView.frame = frame;
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}

#pragma mark - getter
-(UITableView*) tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate     = self;
        _tableView.dataSource   = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
//        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    return _tableView;
}

-(UIImageView*) topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc ]init];
        _topImageView.backgroundColor = [UIColor whiteColor];
        _topImageView.image = [UIImage imageNamed:@"bImage"];
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topImageView;
}

-(DFTransparentBarHeadView*) headView{
    if (!_headView) {
        _headView = [[DFTransparentBarHeadView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width,136)];
        //_headView.backgroundColor = [UIColor blueColor];
    }
    return _headView;
}
@end
