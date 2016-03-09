//
//  CheckTools.h
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/12.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kSuccessStatus @"kSuccessStatus"
#define kFaiseReason    @"kFaiseReson"
@interface CheckTools : NSObject

//  save  存储     get   取值

//第三方登录Uid
+(void)saveUid:(NSString*)Uid;
+(NSString*)getUid;

//第三方登录昵称
+(void)saveUser:(NSString*)user;
+(NSString*)getUser;

/**
 *  登录手机号码
 *
 *  @param account <#account description#>
 */
+(void)saveUserphone:(NSString*)userphone;
+(NSString*)getUserphone;

//物业标题
+(void)savewyTitle:(NSString*)wyTitle;
+(NSString*)getwyTitle;

//物业发布时间
+(void)savewyDate:(NSString*)wyDate;
+(NSString*)getwyDate;

//物业公告url
+(void)savewyUrl:(NSString*)wyUrl;
+(NSString*)getwyUrl;

//物业标题内容
+(void)savewyContent:(NSString*)wyContent;
+(NSString*)getwyContent;

//物业公告图片
+(void)savewyImage:(NSString*)wyImage;
+(NSString*)getwyImage;

/**
 *  设置手机号
 *
 *  @param account <#account description#>
 */
+(void)saveAccount:(NSString*)account;
+(NSString*)getAccount;

/**
 *  设置密码
 *  save  存储
 *  get   取值
 *  @param password <#password description#>
 */
+(void)savePassword:(NSString*)password;
+(NSString*)getPassword;

/**
 *  保存昵称
 *
 *  @param password <#password description#>
 */
+(void)savenickName:(NSString*)nickName;
+(NSString*)getnickName;

/**
 *  保存签名
 *
 *  @param password <#password description#>
 */
+(void)savesignature:(NSString*)signature;
+(NSString*)getsignature;


/**
 *  保存用户头像
 *
 *  @param url <#url description#>
 */
+(void)saveUserVaval:(UIImage*)url withKey:(NSString*)key;
+(UIImage*)getUserVavalwithKey:(NSString*)key;

/**
 *  移除 保存的值
 *
 *  @param key <#key description#>
 */
+(void)removeKeyWithUser:(NSString*)key;

/**
 *  判断密码
 *
 *  @param password succes  reson
 *
 *  @return <#return value description#>
 */
+(NSDictionary *)judgePassword:(NSString*)password;

/**
 *  获取注册信息
 *
 *  @return <#return value description#>
 */
+(NSString*)getResiterInfo;


@end
