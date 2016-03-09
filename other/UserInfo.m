//
//  UserInfo.m
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/11.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "UserInfo.h"
#import "CheckTools.h"

@implementation UserInfo
+(instancetype)shareUser
{
    static UserInfo * info=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info=[[UserInfo alloc] init];
    });
    return info;
}
-(instancetype)init
{
    if (self==[super init]) {
        
        
        
    }
    return self;
}
-(UIImage *)avatarUrl
{
    UIImage * temp=[CheckTools getUserVavalwithKey:self.nickName];
    if (temp==nil) {
        NSString * paht=[[NSBundle mainBundle] pathForResource:@"Icon" ofType:@"png"];

        temp=[UIImage imageWithContentsOfFile:paht];
        
    }
    return temp;
}
-(NSString *)nickName
{
    if (_nickName.length==0) {
        
        _nickName=@"个性签名";
    }
    return _nickName;
}

-(NSString *)signature
{
    if (_signature.length==0) {
        
        _signature=@"昵称";
    }
    return _signature;
}

-(NSString *)useMoney
{
    if (_useMoney.length==0) {
        _useMoney=@"0";
    }
    else if (_useMoney.floatValue<0)
    {
        _useMoney=@"0";
    }
    return _useMoney;
}
-(NSString *)total
{
    if (_total.length==0) {
        _total=@"0";
    }
    return _total;
}
-(void)clreanValues
{
    _total=nil;
    _bounty=nil;
    _cardNo=nil;
    _status=nil;
    _userId=nil;
    _useMoney=nil;
    _avatarUrl=nil;
    _isPayPwd=nil;
    _collection=nil;
    _realStatus=nil;
    _isUpdateName=nil;
    _sessionId=nil;
    _userId=nil;

}
@end
