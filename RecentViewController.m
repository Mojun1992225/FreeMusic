//
//  RecentViewController.m
//  FreeMusic
//
//  Created by mj on 16/1/22.
//  Copyright © 2016年 xiaozi. All rights reserved.
//

#import "RecentViewController.h"
#import "FMSingerModel.h"
#import "DBManager.h"
#import "FMMainTableViewCell.h"

@interface RecentViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    UITableView *tab;
}
@property (strong, nonatomic) NSMutableArray *Array;

@end


@implementation RecentViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
    //刷新 避免用户取消了收藏 还有数据
    [tab reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title = @"最近播放";
    
    [self createUI];
}

-(void)createUI
{
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)style:UITableViewStylePlain];
    tab.dataSource=self;
    tab.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    tab.delegate=self;
    //设置偏移量 解决tableView 底部显示不全问题
    tab.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    //tab.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //得到数据库里面的数据个数
    return [[[DBManager shareManager] allData] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    FMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[FMMainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    NSLog(@"==我的收藏数量 ：%ld====",[[[DBManager shareManager] allData] count]);
    FMSingerModel *model = [[[DBManager shareManager] allData] objectAtIndex:indexPath.row];
    cell.model=model;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark * Table view data source
//滑动cell时点击删除每次删除一个cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0f;
}


//滑动cell时添加删除和编辑按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
//        //更新数据
//        [_Array removeObjectAtIndex:indexPath.row];
//        //更新UI
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    //刷新页面
    [tab reloadData];
    
    return @[deleteRowAction];
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
