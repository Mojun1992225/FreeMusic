//
//  changeNameViewController.m
//
//  Created by 莫骏 on 15/11/27.
//  Copyright (c) 2015年 mojun. All rights reserved.
//

#import "changeNameViewController.h"
#import "MineViewController.h"

@interface changeNameViewController ()
{
    UIView *bgView;
}
@property (nonatomic, strong) UITextField *name;
@end

@implementation changeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor =[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    self.navigation.leftImage =[UIImage imageNamed:@"cm2_icn_back"];
    self.navigation.rightImage =nil;
    self.navigation.navigaionBackColor = [UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    self.navigation.title = @"修改昵称";

    [self createTextFields];

}

-(void)createTextFields
{
    
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 80, frame.size.width, 40)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    
    _name=[self createTextFielfFrame:CGRectMake(20, 10, bgView.frame.size.width-40, 30) font:[UIFont systemFontOfSize:14] placeholder:@"点击修改昵称"];
    //修改placehold的字体颜色
    UIColor *color = [UIColor lightGrayColor];
    _name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"点击修改昵称" attributes:@{NSForegroundColorAttributeName: color}];
    if ([CheckTools getnickName].length
        >0)
    {
        _name=[self createTextFielfFrame:CGRectMake(20, 5,  bgView.frame.size.width-25, 30) font:[UIFont systemFontOfSize:14] placeholder:[CheckTools getnickName]];
        //修改placehold的字体颜色
        UIColor *color = [UIColor lightGrayColor];
        _name.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[CheckTools getnickName] attributes:@{NSForegroundColorAttributeName: color}];
    }
    
    _name.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, bgView.frame.size.height+bgView.frame.origin.y+30,self.view.frame.size.width-20, 37) backImageName:nil title:@"确认" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:17] target:self action:@selector(landClick)];
    landBtn.backgroundColor=[UIColor colorWithRed:72.0f/255.0f green:52.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    landBtn.layer.cornerRadius=5.0f;
    
    [bgView addSubview:_name];
    
    [self.view addSubview:landBtn];
}

-(void)landClick
{
    if ([_name.text isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请设置个昵称吧"];
        return;
    }
    MineViewController *oneself=[[MineViewController alloc]init];
    oneself.name=_name.text;
    [CheckTools savenickName:_name.text];
    [self.navigationController pushViewController:oneself animated:YES];
}


-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftButtonClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_name resignFirstResponder];
}

@end
