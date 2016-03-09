//
//  UserInfo.h
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/11.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UserInfo : NSObject
+(instancetype)shareUser;
@property(copy,nonatomic) NSString *sessionId;
//@property(copy,nonatomic) NSString *token;
@property(copy,nonatomic) NSString *telephone;
@property(copy,nonatomic) NSString *orderNum;
@property(copy,nonatomic) NSString *houseId;
@property(copy,nonatomic) NSString *smsId;
@property(copy,nonatomic) NSString *type;
@property(copy,nonatomic) NSString *wy_name;
@property(copy,nonatomic) NSString *wy_date;
@property(copy,nonatomic) NSString *wy_level;
@property(copy,nonatomic) NSString *wy_type;


@property(copy,nonatomic) NSString * create_time;
@property(copy,nonatomic) NSString* title;


@property(copy,nonatomic) NSString *id;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *address;

@property(copy,nonatomic) NSString *houseCode;
@property(copy,nonatomic) NSString *relaType;


/**
 *  绑卡请求号
 */
@property(copy,nonatomic ) NSString *requestId;


@property(copy,nonatomic ) NSString *quickId;


@property(copy,nonatomic) NSString *message;


/**
 *  code
 */
@property(copy,nonatomic) NSString *code;


/**
 *  头像
 */
@property(strong,nonatomic) UIButton * avatarUrl;

/**
 *  签名
 */
@property(copy,nonatomic) NSString * nickName;
/**
 *  昵称
 */
@property(copy,nonatomic) NSString * signature;

/**
 *  名称
 */
//@property(copy,nonatomic) NSString * name;
/**
 *  实名认证 1、认证 0、未认证2、审核中
 */
@property(copy,nonatomic) NSString * realStatus;

/**
 *  是否是vip  
 1、认证
 0、未认证
 2、审核中
 */
@property(assign,nonatomic) NSInteger isVip;

/**
 *  实名认证 1、认证 0、未认证2、审核中
 */
@property(copy,nonatomic) NSString * isRealName;

/**
 *  1 、已设置 2、未设置
 */
@property(copy,nonatomic) NSString * isPayPwd;
/**
 *  资金总额
 */
@property(copy,nonatomic) NSString * total;

/**
 *  可用余额
 */
@property(copy,nonatomic) NSString * useMoney;
/**
 *  用户编号
 */
@property(copy,nonatomic) NSString * userId;
/**
 *  冻结金额
 */
@property(copy,nonatomic) NSString * noUseMoney;
/**
 *  待收金额
 */
@property(copy,nonatomic) NSString * collection;
/**
 *  奖励金额
 */
@property(copy,nonatomic) NSString * bounty;
/**
 * 冻结金额状态(0: 默认值 1:已冻结 2：未冻结)
 */
@property(copy,nonatomic) NSString * status;
/**
 *  已赚利息总额
 */
@property(copy,nonatomic) NSString * yetinterest;
/**
 *  VIP(到期时间)
 */
@property(copy,nonatomic) NSString * vipDesc;

/**
 *  1、已修改 2、未修改
 */
@property(copy,nonatomic) NSString * isUpdateName;

/**
 *  cardNo身份证号码
 */
@property(copy,nonatomic) NSString * cardNo;

-(void)clreanValues;

@end
