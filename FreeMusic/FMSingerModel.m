//
//  FMSingerModel.m
//  FreeMusic
//
//  Created by zhaojianguo-PC on 14-5-27.
//  Copyright (c) 2014年 xiaozi. All rights reserved.
//

#import "FMSingerModel.h"

@implementation FMSingerModel

#pragma mark  表名
+(NSString *)getTableName
{
    return @"FMSongerInfor";
}

#pragma mark  表版本
+(int)getTableVersion
{
    return 1;
}

+(NSString *)getPrimaryKey
{
    return @"ting_uid";
}

-(NSMutableArray *)itemWith:(NSString *)name
{
    NSMutableArray * array = [FMSingerModel searchWithWhere:[NSString stringWithFormat:@"name like '%%%@%%'",name] orderBy:nil offset:0 count:0];
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (FMSingerModel * sub in array) {
        if ([sub.name length]!=0) {
            if ([sub.company length]!=0) {
                [temp addObject:sub];
            }else{
                [temp1 addObject:sub];
            }
        }
    }
    [temp addObjectsFromArray:temp1];
    return temp;
}

#pragma mark  按姓搜索歌手列表
-(NSMutableArray *)itemTop100:(NSString *)number
{
//    NSMutableArray * array = [FMSingerModel searchWithWhere:[NSString stringWithFormat:@"'songs_total' >1000"] orderBy:nil offset:0 count:50];
    if ([number isEqualToString:@"梁"])
    {
        return [self itemWith:@"李"];
    }
    else
    {
        return [self itemWith:@"梁"];
    }
}

@end
