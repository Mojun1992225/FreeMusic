//
//  FMTDSearchViewController.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14/6/11.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMTDSearchViewController.h"
#import "FMTDMovieViewController.h"
#import "FMTDTableViewCell.h"
#import "FMLoadMoreFooterView.h"


@interface FMTDSearchViewController ()<UIScrollViewDelegate>
{
    BOOL isLoadingMore;
    BOOL isCanLoadMore;
    FMLoadMoreFooterView * footerView;
    int list_total;
}
@end

@implementation FMTDSearchViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    self.navigation.leftImage  = [UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage = nil;
    self.navigation.navigaionBackColor =[UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];

    //self.navigation.title = @"搜索";
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50,32, self.view.size.width-100, 25.0f)];
    _searchBar.delegate =self;
    _searchBar.placeholder = @"输入要搜索的内容";
    _searchBar.backgroundColor =[UIColor whiteColor];
    UIView *searchTextField = nil;
    // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
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


    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.size.height+self.searchBar.origin.y+10, self.view.size.width, self.view.size.height-self.searchBar.size.height-self.searchBar.origin.y-48.5f)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    list_total = 20;
    isLoadingMore = YES;
    footerView = [[FMLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, _tableView.size.width, 70)];
    _tableView.tableFooterView = footerView;

    // Do any additional setup after loading the view.
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}
#pragma mark -
#pragma mark Encode Chinese to ISO8859-1 in URL
-(NSString *)encodeUTF8Str:(NSString *)encodeStr{
    CFStringRef nonAlphaNumValidChars = CFSTR("![        DISCUZ_CODE_1        ]’()*+,-./:;=?@_~");
    NSString *preprocessedString = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)encodeStr, CFSTR(""), kCFStringEncodingUTF8));
    NSString *newStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)preprocessedString,NULL,nonAlphaNumValidChars,kCFStringEncodingUTF8));
    return newStr;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    [_searchBar resignFirstResponder];
    
    if ([array count]!=0) {
        [array removeAllObjects];
    }
    [ProgressHUD show:nil];
    MCDataEngine * network = [MCDataEngine new];
    [network searchTDMovieWith:1 :list_total :@"viewed_all" :[self encodeUTF8Str:_searchBar.text] WithCompletionHandler:^(FMTDMovieList *movieList) {
        array = movieList.movieLists;
        [_tableView reloadData];
        [ProgressHUD dismiss];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } errorHandler:^(NSError *error) {
        [ProgressHUD showError:@"搜索出错,重新搜索."];
    }];
    
}
#define DEFAULT_HEIGHT_OFFSET 44.0f

#pragma mark UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoadingMore && !isCanLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < DEFAULT_HEIGHT_OFFSET) {
            [self loadMore];
        }
    }
}
-(void)loadMore
{
    if (isLoadingMore) {
        [footerView.activeView startAnimating];
        list_total+=20;
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
        isLoadingMore = NO;
        footerView.titleLabel.text = @"搜索中...";
    }
}
-(void)loadMoreData
{
    if (list_total>100){
        list_total = 100;
        isCanLoadMore = YES; // signal that there won't be any more items to load
    }else{
        isCanLoadMore = NO;
    }
    
    if (isCanLoadMore) {
        [self loadMoreCompleted];
    }else{
        MCDataEngine * network = [MCDataEngine new];
        [network searchTDMovieWith:1 :list_total :@"viewed_all" :[self encodeUTF8Str:_searchBar.text] WithCompletionHandler:^(FMTDMovieList *movieList) {
            array = movieList.movieLists;
            [_tableView reloadData];
            [ProgressHUD dismiss];
            [self loadMoreCompleted];
        } errorHandler:^(NSError *error) {
            [ProgressHUD showError:@"搜索出错,重新搜索."];
        }];
    }
}

-(void)loadMoreCompleted
{
    isLoadingMore = YES;
    if (isCanLoadMore) {
        _tableView.tableFooterView = nil;
    }else{
        [footerView.activeView stopAnimating];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    FMTDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[FMTDTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    FMTDMovieModel * model = [array objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMTDMovieModel* model = [array objectAtIndex:indexPath.row];
    FMTDMovieViewController * pushController = [[FMTDMovieViewController alloc] init];
    pushController.model = model;
    [self.navigationController pushViewController:pushController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    _searchBar.hidden=YES;
}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
