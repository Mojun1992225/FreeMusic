//
//  FMPlayingListViewController.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-28.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMPlayingListViewController.h"

@interface FMPlayingListViewController ()

@end

@implementation FMPlayingListViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneEvent)];
    self.navigationItem.rightBarButtonItem = done;
    // Do any additional setup after loading the view.
}

-(void)doneEvent
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
