//
//  ViewController3.m
//  FlipTableView
//
//  Created by mj on 15/7/9.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
        
    self.navigation.leftImage  =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title=@"排行榜";
    
    [self createUI];
}

-(void)createUI
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame=CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height);
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
//    FMSingerModel * model = [array objectAtIndex:indexPath.row];
//    cell.model = model;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
