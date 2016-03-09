//
//  Admob.h
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "JSONModel.h"

@interface Admob : JSONModel
/**
 *  连接类型
 */
@property(copy,nonatomic) NSString* type;
/**
 *  连接地址
 */
@property(copy,nonatomic) NSString * href;

@property(copy,nonatomic) NSString *image;
@property(copy,nonatomic) NSString *name;

@end
