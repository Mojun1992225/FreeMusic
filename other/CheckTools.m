//
//  CheckTools.m
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/12.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "CheckTools.h"
#define kDocumentDirectory  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation CheckTools
#pragma mark - 手机号码
+(BOOL)isPhoneNumber:(NSString*)number{
//    NSString *regex = @"1[3458]([0-9]){9}";
    
    //
     NSString *regex = @"^[\\d]{11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:number]) {
        return NO;
    }
    
    
    return YES;
}

+(BOOL)isNumberValues:(NSString *)number
{
    //^[0-9]*$
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:number]) {
        return NO;
    }
    
    
    return YES;
}

+(BOOL)isCardNumberWithNumber:(NSString *)number
{
    NSString *regex = @"^([0-9]{16}|[0-9]{19})$";
    
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:number]) {
        return NO;
    }
    
    
    return YES;
}

+(void)saveUser:(NSString*)user
{
    [[NSUserDefaults standardUserDefaults] setValue:user forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUser
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];

}

+(void)saveUid:(NSString*)Uid
{
    [[NSUserDefaults standardUserDefaults] setValue:Uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
}

+(void)savewyTitle:(NSString *)wyTitle
{
    [[NSUserDefaults standardUserDefaults] setValue:wyTitle forKey:@"wyTitle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getwyTitle
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wyTitle"];

}

+(void)savewyDate:(NSString *)wyDate
{
    [[NSUserDefaults standardUserDefaults] setValue:wyDate forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString *)getwyDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];

}


+(void)savewyUrl:(NSString*)wyUrl
{
    [[NSUserDefaults standardUserDefaults] setValue:wyUrl forKey:@"content"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(NSString*)getwyUrl
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"content"];

}


+(void)savewyImage:(NSString*)wyImage
{
    [[NSUserDefaults standardUserDefaults] setValue:wyImage forKey:@"image"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getwyImage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
}

+(void)savewyContent:(NSString *)wyContent
{
    [[NSUserDefaults standardUserDefaults] setValue:wyContent forKey:@"contentSimple"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getwyContent
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"contentSimple"];
}

+(void)saveUserphone:(NSString *)userphone
{
    [[NSUserDefaults standardUserDefaults] setValue:userphone forKey:@"userphone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getUserphone
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
}



+(void)saveAccount:(NSString *)account
{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getAccount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

//昵称
+(void)savenickName:(NSString *)nickName
{
    [[NSUserDefaults standardUserDefaults] setValue:nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getnickName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}

//签名
+(void)savesignature:(NSString *)signature
{
    [[NSUserDefaults standardUserDefaults] setValue:signature forKey:@"signature"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getsignature
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"signature"];
}

+(void)savePassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+(NSString *)getPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];

}

+(void)saveUserVaval:(UIImage *)url withKey:(NSString *)key
{
    if (key.length==0) {
        return;
    }
    NSData * temp=UIImageJPEGRepresentation(url, 0.5);
    [[NSUserDefaults standardUserDefaults] setValue:temp forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(UIImage *)getUserVavalwithKey:(NSString *)key
{
    if (key.length==0) {
        return nil;
    }
    NSData * temp=[[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [UIImage imageWithData:temp];

}
+(void)removeKeyWithUser:(NSString *)key
{
    if (key.length==0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
}




+(NSDictionary *)judgePassword:(NSString *)password
{
    BOOL succes=YES;
    NSString * reason=@"";
    if (password.length<6) {
        reason=@"密码至少大于6位";
        succes=NO;
    }
    else if (password.length>16)
    {
        reason=@"密码最大16位";
        succes=NO;

    }
    
    
    return @{kSuccessStatus:@(succes),kFaiseReason:reason};
}

+(NSString *)getResiterInfo
{
     NSString *path = [[NSBundle mainBundle] pathForResource:@"regsiterWord" ofType:@"docx"];
    return path;
}

+(NSString *)getInvestmentInfo
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"touBiaoWord" ofType:@"docx"];
    return path;
}



@end
