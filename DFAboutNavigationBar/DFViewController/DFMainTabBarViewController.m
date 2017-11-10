//
//  DFMainTabBarViewController.m
//  DFAboutNavigationBar
//
//  Created by daifeng on 2017/11/10.
//  Copyright © 2017年 daifeng. All rights reserved.
//

#import "DFMainTabBarViewController.h"
#import "DFMainNavViewController.h"
#import "DFScaleViewController.h"
#import "DFHideBarViewController.h"
#import "DFTransparentBarViewController.h"

@interface DFMainTabBarViewController ()

@end

@implementation DFMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DFScaleViewController *scaleVc = [[DFScaleViewController alloc]init];
    [self addChildViewControllerWithTitle:@"缩放" viewController:scaleVc imageName:@"scale" selImageName:@"scale_selected"];
    
    DFHideBarViewController *hideBarVc = [[DFHideBarViewController alloc] init];
    [self addChildViewControllerWithTitle:@"隐藏" viewController:hideBarVc imageName:@"hidebar" selImageName:@"hidebar_selected"];
    
    DFTransparentBarViewController *transparentBarVc = [[DFTransparentBarViewController alloc] init];
    [self addChildViewControllerWithTitle:@"透明" viewController:transparentBarVc imageName:@"transparent" selImageName:@"transparent_selected"];
}


#pragma mark - private method

/**
 tab bar vc add child view controller

 @param title tabbar title
 @param vc child vc
 @param imgName tabbar image
 @param selImgName tabbar selected image
 */
-(void) addChildViewControllerWithTitle:(NSString*) title viewController:(UIViewController*)vc imageName:(NSString*) imgName selImageName:(NSString*) selImgName{
    
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[UIImage imageNamed:imgName]];
    [vc.tabBarItem setSelectedImage:[self imageWithOriginRenderingMode:selImgName]];
    
    DFMainNavViewController *mainNavVc = [[DFMainNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:mainNavVc];
}

/**
 加载原始图片不被系统渲染

 @param imageName image name
 @return image
 */
-(UIImage*) imageWithOriginRenderingMode:(NSString*) imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
