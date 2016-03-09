//
//  DBManager.m
//  Limit_Demo_New
//
//  Created by LongHuanHuan on 15/5/28.
//  Copyright (c) 2015年 ___LongHuanHuan___. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

//GCD的写法 保证只实例化一次
+ (DBManager *)shareManager{
    static DBManager *_DB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_DB == nil) {
            _DB = [[DBManager alloc] init];
        }
    });
    return _DB;
}

//加锁
//+ (DBManager *)shareManager{
//    static DBManager *_DB = nil;
//    @synchronized(self){
//        if (_DB == nil) {
//            _DB = [[DBManager alloc] init];
//        }
//    }
//    return _DB;
//}


//普通的写法
//+ (DBManager *)shareManager{
//    static DBManager *_DB = nil;
//    if (_DB == nil) {
//        _DB = [[DBManager alloc] init];
//    }
//    return _DB;
//}

- (id)init{
    self = [super init];
    if (self) {
        //实例化数据库对象的时候 我们发现他需要一个路径
        //数据库是存到我们应用沙盒
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/appdb.db"];
        NSLog(@"打印路径 %@",path);
        dataBase = [[FMDatabase alloc] initWithPath:path];
        if ([dataBase open]) {
            //去创建一个表
            NSString *sql = @"create table if not exists app(applicationId varchar(32),name varchar(128),iconUrl varchar(1024))";
            BOOL isFinish = [dataBase executeUpdate:sql];
            if (isFinish) {
                NSLog(@"创建表格成功");
            }else{
                NSLog(@"创建表格失败: %@",dataBase.lastErrorMessage);
            }
        }else{
            NSLog(@"打开数据库失败");
        }
        
    }
    return self;
}

//增加
- (BOOL)insertToTable:(FMSingerModel *)model{
    //增加的sq语句
    //insert into app (applicationid,appname,iconurl) values (?,?,?)
    NSString *sql = @"insert into app (applicationId,name,iconUrl) values (?,?,?)";
    BOOL isFinish = [dataBase executeUpdate:sql,model.avatar_big,model.name,model.company];
    if (isFinish) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败:%@",dataBase.lastErrorMessage);
    }
    return isFinish;
}
//删除
- (BOOL)deleteToTable:(FMSingerModel *)model{
    //appstore 名字命名 appstore如果存在这个应用的名字，你是不允许使用这个名字 但是有一点 我们新建应用的时候 会去取一个名字 这个名字当你取好之后（天天跑步）别人也是不能使用 但是有一点：当你3个月以后 你还没有上传二进制文件到appstore里面，他认为你在占名字，然后别人可以使用！你下线的应用3个月之后别人就可以使用这个名字
    
    //删除的sql语句
    //delete from app where applicationid = ?
    
    NSString *sql = @"delete from app where applicationId = ?";
    BOOL isFinish = [dataBase executeUpdate:sql,model.name];
    if (isFinish) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败:%@",dataBase.lastErrorMessage);
    }
    return isFinish;
}
//修改
- (BOOL)changeToTable:(FMSingerModel *)model{
    
    //修改一条数据
    //update userInfo set name = ? where id = ?
    NSString *sql = @"update app set name = ? where id = ?";
    BOOL isFinish = [dataBase executeUpdate:sql,model.avatar_big,model.name];
    if (isFinish) {
        NSLog(@"修改成功");
    }else{
        NSLog(@"修改失败:%@",dataBase.lastErrorMessage);
    }
    return isFinish;
}

//查询
//第一我们要从本地数据库里面 查询出来 （我们收藏的数据，要给用户展示出来）
- (NSArray *)allData{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSString *sql = @"select * from app";
    FMResultSet *set = [dataBase executeQuery:sql];
    while([set next]) {
        FMSingerModel *model = [[FMSingerModel alloc] init];
        //给model赋值
        model.avatar_big =[set stringForColumn:@"avatar_big"];
        model.company =@"滚石唱片公司";
        model.name = @"李心浩";
        [dataArray addObject:model];
    }
    return dataArray;
}
//select applicationid from app where applicationid = ?
- (BOOL)isExistsWithTable:(FMSingerModel *)model{
    NSString *sql = @"select applicationId from app where applicationId = ?";
    
    FMResultSet *set = [dataBase executeQuery:sql,model.avatar_big];
    
    return [set next];
}

@end
