//
//  MineViewController.m
//  FreeMusic
//
//  Created by mj on 16/1/18.
//  Copyright © 2016年 xiaozi. All rights reserved.
//

#import "MineViewController.h"
#import "FMMainViewController.h"
//修改个人信息
#import "changeNameViewController.h"
#import "changeSignViewController.h"

@interface MineViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
{
    UITableView *tab;
    UILabel *describe;
    UILabel *describe1;
}
@property (nonatomic,strong) UIButton *head; //头像


@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    self.view.backgroundColor = [UIColor whiteColor];
    //self.navigation.leftImage =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.leftImage=nil;
    self.navigation.rightImage =nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title = @"账号";
    
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
    
    
    CGRect frame=[UIScreen mainScreen].bounds;
    UIButton *sure=[[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height-180, frame.size.width, 40)];
    [sure setTitle:@"退出当前账号" forState:UIControlStateNormal];
    sure.font=[UIFont systemFontOfSize:15.0f];
    [sure setTitleColor:[UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [sure setBackgroundColor:[UIColor whiteColor]];
    [sure addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [tab addSubview:sure];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        return 0;
    }
    return 0.1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
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
            return 80;
        }
        else
        {
            return 50;
        }
    }
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            cell.textLabel.text=@"头像";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            _head=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-_head.frame.size.width-80, 10, 60, 60)];
            [_head setBackgroundImage:[UIImage imageNamed:@"ic_tabbar_find"] forState:UIControlStateNormal];
            [_head setImage:[CheckTools getUserVavalwithKey:[UserInfo shareUser].nickName] forState:UIControlStateNormal];
            _head.layer.cornerRadius=30;
            _head.layer.masksToBounds = YES;
            _head.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
            [_head addTarget:self action:@selector(changeHeadView1:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_head];
        }
        else if (indexPath.row==1)
        {
            cell.textLabel.text=@"昵称";
            cell.textLabel.font=[UIFont systemFontOfSize:15];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            describe=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-220,10, 180, 30)];
            describe.textColor=[UIColor lightGrayColor];
            describe.text=[CheckTools getnickName];
            if ([CheckTools getnickName].length <=0) {
                describe.text=@"亲,设置个昵称吧";
            }
            describe.textAlignment=UITextAlignmentRight;
            describe.font=[UIFont systemFontOfSize:14.0f];
            [cell addSubview:describe];
            
        }
        else if (indexPath.row==2)
        {
            cell.textLabel.text=@"签名";
            cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            describe1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-220,10, 180, 30)];
            //describe.backgroundColor=[UIColor redColor];
            describe1.text=[CheckTools getsignature];
            if ([CheckTools getsignature].length <=0) {
                describe1.text=@"亲,设置签名个吧";
            }
            describe1.textAlignment=UITextAlignmentRight;
            describe1.textColor=[UIColor lightGrayColor];
            describe1.font=[UIFont systemFontOfSize:14.0f];
            [cell addSubview:describe1];
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"修改密码";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
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
        if (indexPath.row==1)
        {
            //修改昵称
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:[[changeNameViewController alloc]init] animated:YES];
        }
        else if (indexPath.row==2)
        {
            //修改签名
            self.tabBarController.tabBar.hidden=YES;
            [self.navigationController pushViewController:[[changeSignViewController alloc]init] animated:YES];
        }
    }
    else if(indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            //修改密码
            //[self.navigationController pushViewController:[[changePassWardViewController alloc]init] animated:YES];
        }
    }
    
}

-(void)exit
{
    UIActionSheet *exit= [[UIActionSheet alloc] initWithTitle:@"退出应用并注销当前账号" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"退出", nil];
    exit.delegate=self;
    exit.tag=100;
    exit.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [exit showInView:self.view];
}

-(void)changeHeadView1:(UIButton *)tap
{
    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"更改图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册上传", nil];
    menu.tag=200;
    menu.delegate=self;
    menu.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [menu showInView:self.view];
    
}

//*************************代理方法*******************************
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"index:%zd",buttonIndex);
    //0->拍照，1->相册
    if (actionSheet.tag==200)
    {
        if (buttonIndex == 0) {
            [self snapImage];
        } else if (buttonIndex == 1) {
            [self localPhoto];
        }
    }
    //退出当前账号
    else if (actionSheet.tag==100)
    {
        if (buttonIndex==0) {
            //self.tabBarController.tabBar.hidden=YES;
            //[self.navigationController pushViewController:[[MMZCViewController alloc]init] animated:YES];
            //直接退出程序
            self.view.backgroundColor=[UIColor whiteColor];
            exit(0);
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //完成选择
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"type:%@",type);
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
            //设置头像
            [_head setImage:image forState:UIControlStateNormal];
            [CheckTools saveUserVaval:image withKey:[UserInfo shareUser].nickName];
            //上传头像
            //[self imageUpload:image];
            
      }];
    }
}



//*****************************拍照**********************************
- (void) snapImage
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        ipc.navigationBar.barTintColor =[UIColor whiteColor];
        ipc.navigationBar.tintColor = [UIColor whiteColor];
        ipc.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        NSLog(@"模拟器无法打开照相机");
    }
}

#define CommonThimeColor HEXCOLOR(0x11a0ee)
-(void)localPhoto
{
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.barTintColor =[UIColor whiteColor];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor blackColor]};
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
    }];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)leftButtonClickEvent
{
    [self.navigationController pushViewController:[[changeNameViewController alloc]init] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
