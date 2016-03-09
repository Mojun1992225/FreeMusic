//
//  FMHomeViewController.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14/6/5.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMHomeViewController.h"
#import "DownloadViewController.h"
#import "RecentViewController.h"
#import "MySingerViewController.h"
#import "FavViewController.h"

@interface FMHomeViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    UITableView *tab;
}
@end

@implementation FMHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage =nil;
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title = @"我的音乐";
    
    [self createUI];
}

-(void)createUI
{
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStyleGrouped];
    tab.dataSource=self;
    tab.backgroundColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    tab.delegate=self;
    //设置偏移量 解决tableView 底部显示不全问题
    //tab.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    //tab.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        return 3;
    }
    return 0.1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 3;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 40;
        }
        else
        {
            return 40;
        }
    }
    return 40;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 25, 25)];
            image.image=[UIImage imageNamed:@"frame02cover01"];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 60, 20)];
            label.text=@"下载音乐";
            label.font=[UIFont systemFontOfSize:14.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            [cell addSubview:image];
            [cell addSubview:label];
        }
        else if (indexPath.row==1)
        {
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 25, 25)];
            image.image=[UIImage imageNamed:@"frame02cover02"];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 60, 20)];
            label.text=@"最近播放";
            label.font=[UIFont systemFontOfSize:14.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [cell addSubview:image];
            [cell addSubview:label];
        }
        else if (indexPath.row==2)
        {
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 25, 25)];
            image.image=[UIImage imageNamed:@"cm2_rdi_btn_loved"];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 60, 20)];
            label.text=@"我的歌手";
            label.font=[UIFont systemFontOfSize:14.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [cell addSubview:image];
            [cell addSubview:label];
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8, 25, 25)];
            image.image=[UIImage imageNamed:@"cm2_rdi_btn_love"];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 90, 20)];
            label.text=@"我喜欢的音乐";
            label.font=[UIFont systemFontOfSize:14.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [cell addSubview:image];
            [cell addSubview:label];        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        
        if (indexPath.row==0)
        {
            //下载音乐
            [self.navigationController pushViewController:[[DownloadViewController alloc]init] animated:YES];
        }
        else if (indexPath.row==1)
        {
            //最近播放
            [self.navigationController pushViewController:[[RecentViewController alloc]init] animated:YES];
        }
        else
        {
            //我的歌手
            [self.navigationController pushViewController:[[MySingerViewController alloc]init] animated:YES];
        }
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            //我喜欢的音乐
            [self.navigationController pushViewController:[[FavViewController alloc]init] animated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
