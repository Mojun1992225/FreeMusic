//
//  FavViewController.m
//  FreeMusic
//
//  Created by mj on 16/1/22.
//  Copyright © 2016年 xiaozi. All rights reserved.
//

#import "FavViewController.h"

@interface FavViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    UITableView *tab;
}
@property (strong, nonatomic) NSMutableArray *Array;

@end


@implementation FavViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title = @"我喜欢的音乐";
    
    [self createUI];
}

-(void)createUI
{
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStylePlain];
    tab.dataSource=self;
    tab.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    tab.delegate=self;
    //设置偏移量 解决tableView 底部显示不全问题
    //tab.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    //tab.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
