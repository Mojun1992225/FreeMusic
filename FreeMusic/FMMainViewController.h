//
//  FMMainViewController.h
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseViewController.h"

//vc
#import "FMMainViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

@class FMSingerModel;


@interface FMMainViewController : FMBaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView * _tableView;

}

@property (strong,nonatomic) UISearchBar *searchBar;
@property (nonatomic,strong) FMSingerModel * model;

//vc
@property (strong,nonatomic)FMMainViewController *headVC;
@property (strong,nonatomic)ViewController1 *carVC;
@property (strong,nonatomic)ViewController2 *beautyVC;
@property (strong,nonatomic)ViewController3 *entertainmentVC;

@end
