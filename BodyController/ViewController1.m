//
//  ViewController1.m
//  FlipTableView
//
//  Created by mj on 15/7/9.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

#import "ViewController1.h"
#import "FMMainTableViewCell.h"
#import "FMSingerSongListViewController.h"
#import "FMMusicViewController.h"
#import "ViewController2.h"

@interface ViewController1 ()<UIScrollViewDelegate>
{
    NSMutableArray * array;
    UIScrollView *sc;
    UIImageView *imageView;
}
@property(nonatomic, strong)UIPageControl *pageControl;

@end

@implementation ViewController1

-(void)viewWillAppear:(BOOL)animated
{
    _searchBar.hidden=NO;
    //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigation.leftImage  =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title=@"歌单";
    
    array = [NSMutableArray new];
    
    FMSingerModel * model = [FMSingerModel new];
    array = [model itemTop100:@"梁"];
    

    // Create the search display controller
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame=CGRectMake(0,100, self.view.frame.size.width,self.view.frame.size.height);
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5,70, self.view.size.width-10, 25.0f)];
    _searchBar.delegate =self;
    _searchBar.barTintColor=[UIColor colorWithRed:131.0f/255.0f green:13.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
    _searchBar.placeholder = @"搜索:音乐、歌词、电台";
    _searchBar.backgroundColor =[UIColor whiteColor];
    UIView *searchTextField = nil;
    // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
    //_searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.cornerRadius = 3;
    _searchBar.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    _searchBar.layer.borderWidth = 1;
    _searchBar.delegate = self;
    searchTextField = [[[_searchBar.subviews firstObject] subviews] lastObject];
    
    searchTextField.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    
    for (UIView *view in _searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    [_searchBar setShowsCancelButton:NO];
    [self.view addSubview: _searchBar];

    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    [_searchBar resignFirstResponder];
    
    if ([array count]!=0) {
        [array removeAllObjects];
    }
    [ProgressHUD show:nil];
    [self getSingerData];
}

-(void)getSingerData
{
    FMSingerModel * model = [FMSingerModel new];
    array = [model itemWith:_searchBar.text];
    [_tableView reloadData];
    [ProgressHUD dismiss];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - Table view data source
#warning Potentially incomplete method implementation.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    FMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[FMMainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    FMSingerModel * model = [array objectAtIndex:indexPath.row];
    cell.model = model;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell了");
    _searchBar.hidden=YES;
    FMSingerModel * model = [array objectAtIndex:indexPath.row];
    FMSingerSongListViewController *pushController = [[FMSingerSongListViewController alloc] init];
    pushController.singerModel = model;
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
