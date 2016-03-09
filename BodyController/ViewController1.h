//
//  ViewController1.h
//  FlipTableView
//
//  Created by mj on 15/7/9.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBaseViewController.h"

@interface ViewController1 : FMBaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView * _tableView;
    
}

@property (strong,nonatomic) UISearchBar *searchBar;@end
