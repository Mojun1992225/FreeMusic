//
//  ViewController2.m
//  FlipTableView
//
//  Created by mj on 15/7/9.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigation.leftImage  =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor =[UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title=@"主播电台";

}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
