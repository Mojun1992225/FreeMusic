//
//  DBManager.h
//  Limit_Demo_New
//
//  Created by LongHuanHuan on 15/5/28.
//  Copyright (c) 2015年 ___LongHuanHuan___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMSingerModel.h"
#import "FMSongModel.h"

@interface DBManager : NSObject{
    
    //操作数据库的对象
    FMDatabase *dataBase;
}

+ (DBManager *)shareManager;

//增加
- (BOOL)insertToTable:(FMSingerModel *)model;
//删除
- (BOOL)deleteToTable:(FMSingerModel *)model;
//修改
- (BOOL)changeToTable:(FMSingerModel *)model;

//查询
- (NSArray *)allData;

//查询这个数据库里面是否已经包含了这个app
- (BOOL)isExistsWithTable:(FMSingerModel *)model;

@end
