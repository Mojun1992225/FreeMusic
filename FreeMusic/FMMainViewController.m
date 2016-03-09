//
//  FMMainViewController.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMMainViewController.h"
#import "FMMainTableViewCell.h"
#import "FMSingerSongListViewController.h"
#import "FMMusicViewController.h"

//3rc
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "UIButton+WebCache.h"
#import "ZMZScrollView.h"

//讯飞语音SDK
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlyDataUploader.h"
#import "iflyMSC/IFlyContact.h"
#import "iflyMSC/iflyMSC.h"

#define ScreeFrame [UIScreen mainScreen].bounds
@interface FMMainViewController ()<UIScrollViewDelegate,SegmentTapViewDelegate,FlipTableViewDelegate,UISearchBarDelegate,IFlyRecognizerViewDelegate>
{
    NSMutableArray * array;
    UIScrollView *sc;
    UIImageView *imageView;
    IFlyRecognizerView *_iflyRecognizerView;

}
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FlipTableView *flipView;
@property (strong, nonatomic) NSMutableArray *controllsArray;

@property (nonatomic,copy) NSString *single_name;
@property (nonatomic,copy) NSString *single_image;
@property (nonatomic,copy) NSString *single_company;
@property (strong, nonatomic) NSMutableArray *single_arr;

@property (strong,nonatomic)UIScrollView *scrollView;//滚动式视图,选中按钮时,会滚动

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height
#define SEARCHBAR_HEIGHT 40
#define SCROLLVIEW_HEIGHT 200

@end

@implementation FMMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    _searchBar.hidden=NO;
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _searchBar.hidden=YES;
    //设置回非语义识别
    //[IFlySpeechUtility destroy];
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
    
    //数组初始化
    array = [NSMutableArray new];
    FMSingerModel * model = [FMSingerModel new];
    //model传什么姓返回什么姓的歌曲
    array = [model itemTop100:@"李"];

    
    self.navigation.leftImage  =[UIImage imageNamed:@"btn_left_music"];
    self.navigation.rightImage = [UIImage imageNamed:@"btn_right_vinyl"];
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    
    //创建分页
    //[self initFlipTableView];

    
    //创建搜索框
    [self createsearchBar];
    //创建UI
    [self createUI];
    //创建Segment
    [self initSegment];
    [self createScrollView];
    //讯飞语音
    [self createMSC];

}

-(void)createMSC
{
    NSString *initString = [NSString stringWithFormat:@"%@=%@", [IFlySpeechConstant APPID], @"56a6ca17"];
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    _iflyRecognizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    _iflyRecognizerView.delegate = self;
    [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];

}

#pragma mark IFlyRecognizerViewDelegate － 讯飞语音返回结果
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@", key];
    }
    _searchBar.text = [NSString stringWithFormat:@"%@%@", _searchBar.text, result];
    [_searchBar resignFirstResponder];
    
    if ([array count]!=0) {
        [array removeAllObjects];
    }
    [ProgressHUD show:nil];
    [self getSingerData];
    //[self getSingerData];

}

- (void)onError:(IFlySpeechError *)error
{
    NSLog(@"errorCode:%@", [error errorDesc]);
}

-(void)createsearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50,32, self.view.size.width-100, 25.0f)];
    _searchBar.delegate =self;
    _searchBar.barTintColor=[UIColor colorWithRed:131.0f/255.0f green:13.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
    _searchBar.placeholder = @"搜索:音乐、歌词、电台";
    _searchBar.backgroundColor =[UIColor whiteColor];
    UIView *searchTextField = nil;
    // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
    //_searchBar.barTintColor = [UIColor whiteColor];
    _searchBar.layer.masksToBounds = YES;
    _searchBar.layer.cornerRadius = 3;
    _searchBar.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor colorWithRed:192.0f/255.0f green:37.0f/255.0f blue:67.0f/255.0f alpha:1.0f]);
    _searchBar.layer.borderWidth = 1;
    _searchBar.delegate = self;
    searchTextField = [[[_searchBar.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = [UIColor whiteColor];
    
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
    [self.navigationController.view addSubview: _searchBar];
}

-(void)createUI
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame=CGRectMake(0,260, self.view.frame.size.width,self.view.frame.size.height);
    _tableView.delegate =self;
    _tableView.dataSource = self;
    //设置分割线color
    [_tableView   setSeparatorColor:[UIColor    whiteColor]];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
    [self.view addSubview:_tableView];
    
    
    //创建首页九宫格歌手信息
    for (int i = 0; i <[array count]; i ++)
    {
        int n =  15 + i % 3 * 90 + i % 3 * 10;
        int m = 15 + i / 3 * 110 + i / 3 * 40;
        
        _model= [array objectAtIndex:i];
        _single_name=_model.name;
        _single_image=_model.avatar_big;
        _single_company=_model.company;
        
        UIButton * bun = [UIButton buttonWithType:UIButtonTypeCustom];
        bun.frame = CGRectMake(n, m, 90, 90);
        [bun setImageWithURL:[NSURL URLWithString:_single_image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"frame03cover05"]];
        [bun setTitle:_single_name forState:UIControlStateNormal];
        //NSLog(@"======歌手名字🐶🐶===%@==========",_single_name);
        bun.tag = i + 1000;
        [bun addTarget:self action:@selector(buttonSix:) forControlEvents:UIControlEventTouchUpInside];
        [_tableView addSubview:bun];
        
        //更多按钮
        UIButton *more=[[UIButton alloc]initWithFrame:CGRectMake(bun.frame.size.width-35,0, 40, 15)];
        [more setTitle:[NSString stringWithFormat:@"%d万",arc4random() % 100] forState:UIControlStateNormal];
        [more setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         more.font=[UIFont systemFontOfSize:10.0f];
        [more setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
        [more setImage:[UIImage imageNamed:@"ic_erji"] forState:UIControlStateNormal];
        [more setImageEdgeInsets:UIEdgeInsetsMake(0, 18, 0, -18)];
        [bun addSubview:more];

        //single_name
        UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(bun.frame.origin.x,bun.frame.size.height+bun.frame.origin.y+5, 70, 15)];
        name.text=_single_name;
        name.font=[UIFont systemFontOfSize:12.0f];
        [_tableView addSubview:name];
        
        //single_company
        UILabel *des=[[UILabel alloc]initWithFrame:CGRectMake(name.frame.origin.x,name.frame.size.height+name.frame.origin.y+5, 90, 15)];
        des.text=_single_company;
        des.font=[UIFont systemFontOfSize:11.0f];
        [_tableView addSubview:des];
        [_tableView reloadData];
    }

}

#pragma mark -button的点击事件
-(void)buttonSix:(UIButton *)but
{
    _searchBar.hidden=YES;
    NSInteger clickedButtonIndex=but.tag-1000;

    FMSingerSongListViewController *pushController = [[FMSingerSongListViewController alloc] init];
    pushController.singerModel =[array objectAtIndex:clickedButtonIndex];
    NSLog(@"%ld",clickedButtonIndex);
    [self.navigationController pushViewController:pushController animated:YES];
}

#pragma mark 轮播广告
- (void)createScrollView
{
    ZMZScrollView *ZScroller = [[ZMZScrollView alloc]initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 115)];
    ZScroller.imageNameArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    ZScroller.UIPageControlOfStyle = UIPageControlOfStyleCenter;
       
    [self.view addSubview:ZScroller];
    
    //
    UIButton *like=[[UIButton alloc]initWithFrame:CGRectMake(10, ZScroller.frame.size.height+120, 20, 20)];
    [like setImage:[UIImage imageNamed:@"ic_hot"] forState:UIControlStateNormal];
    [self.view addSubview:like];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(35, ZScroller.frame.size.height+120, 80, 20)];
    label.font=[UIFont systemFontOfSize:14.0f];
    label.text=@"最新推荐";
    [self.view addSubview:label];
    
    //
    UIButton *more=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-70, ZScroller.frame.size.height+125, 60, 10)];
    [more setTitle:@"更多" forState:UIControlStateNormal];
    more.font=[UIFont systemFontOfSize:12.0f];
    [more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [more setTitleEdgeInsets:UIEdgeInsetsMake(1, -13, -1, 13)];
    [more setImage:[UIImage imageNamed:@"gb_right_icon"] forState:UIControlStateNormal];
    [more setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, -30)];
    [more addTarget:self action:@selector(moveSinger) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:more];

}

-(void)moveSinger
{
    [self.navigationController pushViewController:[[ViewController1 alloc]init] animated:YES];
}


-(void)initSegment{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, ScreeFrame.size.width, 40) withDataArray:[NSArray arrayWithObjects:@"推荐",@"歌单",@"主播电台",@"排行榜", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}

-(void)initFlipTableView
{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    
    FMMainViewController *v1 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"first"];
    ViewController1 *v2 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    ViewController2 *v3 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"third"];
    ViewController3 *v4 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"fouth"];
    
    [self.controllsArray addObject:v1];
    [self.controllsArray addObject:v2];
    [self.controllsArray addObject:v3];
    [self.controllsArray addObject:v4];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    [self.view addSubview:self.flipView];
}

#pragma mark -------- select Index
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.flipView selectIndex:index];
    if (index==0)
    {
        NSLog(@"推荐");
        [self.navigationController pushViewController:[[FMMainViewController alloc]init] animated:YES];
    }
    else if (index==1)
    {
        NSLog(@"歌单");
        [self.navigationController pushViewController:[[ViewController1 alloc]init] animated:YES];
    }
    else if (index==2)
    {
        NSLog(@"主播电台");
        _searchBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:[[ViewController2 alloc]init] animated:YES];
    }
    else
    {
        NSLog(@"排行榜");
        _searchBar.hidden=YES;
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController pushViewController:[[ViewController3 alloc]init] animated:YES];
    }

    
}
-(void)scrollChangeToIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    [self.segment selectIndex:index];
    if (index==0)
    {
        NSLog(@"推荐");
    }
    else if (index==1)
    {
        NSLog(@"歌单");
    }
    else if (index==2)
    {
        NSLog(@"主播电台");
    }
    else
    {
        NSLog(@"排行榜");
    }
}


-(void)leftButtonClickEvent
{
   // NSLog(@"首页左边按钮");
   // [SVProgressHUD showInfoWithStatus:@"客官别急撒"];
    //_searchBar.hidden=YES;
  //  if (globle.isPlaying) {
//        FMMusicViewController * pushController = [FMMusicViewController shareMusicViewController];
//        [self.navigationController pushViewController:pushController animated:YES];
 //   }
    [_iflyRecognizerView start];
}

-(void)rightButtonClickEvent
{
    NSLog(@"dssds");
    _searchBar.hidden=YES;
    if (globle.isPlaying) {
        FMMusicViewController * pushController = [FMMusicViewController shareMusicViewController];
        [self.navigationController pushViewController:pushController animated:YES];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
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
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；。（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [_searchBar.text stringByTrimmingCharactersInSet:set];
    array = [model itemWith:trimmedString];
    //搜索的时候重新创建ui来刷新数据
    [self createUI];
    [_tableView reloadData];
    [ProgressHUD dismiss];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    //[_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    // _searchBar.text=nil;

}

#pragma mark - Table view data source
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
//    NSLog(@"=====%lu=======",(unsigned long)array.count);
//    //此判断可防止刷新cell崩溃
//    if([array count] > 0 && [array count] > indexPath.row)
//    {
//        FMSingerModel * model = [array objectAtIndex:indexPath.row];
//    }
//    else
//    {
//        [SVProgressHUD showInfoWithStatus:@"客官别急撒"];
//        [_iflyRecognizerView cancel];
//    }
//    //FMSingerModel * model = [array objectAtIndex:indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"点击cell了");
//    _searchBar.hidden=YES;
//    FMSingerModel * model = [array objectAtIndex:indexPath.row];
//    FMSingerSongListViewController *pushController = [[FMSingerSongListViewController alloc] init];
//    pushController.singerModel = model;
//    [self.navigationController pushViewController:pushController animated:YES];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}


@end
