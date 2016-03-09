//
//  Tools.m
//  360VIPManager
//
//  Created by guo on 15/8/14.
//  Copyright (c) 2015年 中超 曹. All rights reserved.
//

#import "Tools.h"
#import "TOMSMorphingLabel.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation Tools

//页面未开放时显示
+ (UIView*)getEmptyView
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0, ScreenWidth, ScreenHeight - 113.0f)];
    emptyView.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome"]];
    float imageWidth=60;
    imageView.frame = CGRectMake(ScreenWidth/2- imageWidth/2, emptyView.frame.size.height/2-imageWidth+20, imageWidth, imageWidth);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [emptyView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((emptyView.frame.size.width-110)/2, imageView.frame.size.height+imageView.frame.origin.y+10, 110.0f, 40.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"敬请期待";
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0x999999);
    [emptyView addSubview:titleLabel];
    
    return emptyView;
}

//无数据时显示
+ (UIView*)getEmptyView1
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0, ScreenWidth, ScreenHeight - 113.0f)];
    emptyView.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"welcome"]];
    float imageWidth=60;
    imageView.frame = CGRectMake(ScreenWidth/2- imageWidth/2, emptyView.frame.size.height/2-imageWidth+20, imageWidth, imageWidth);
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    [emptyView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((emptyView.frame.size.width-110)/2, imageView.frame.size.height+imageView.frame.origin.y+10, 110.0f, 40.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"暂无数据";
    titleLabel.font=[UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0x999999);
    [emptyView addSubview:titleLabel];
    
    return emptyView;
}

+ (UIView*)getEmptyView2
{
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 200, ScreenWidth, ScreenHeight - 113.0f)];
    emptyView.backgroundColor=[UIColor whiteColor];
    
    
     UIButton *_head=[[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth-75)/2, emptyView.frame.size.height/2-120, 75, 75)];
    if (![CheckTools getUserVavalwithKey:[UserInfo shareUser].nickName]==0)
    {
        [_head setImage:[CheckTools getUserVavalwithKey:[UserInfo shareUser].nickName] forState:UIControlStateNormal];
    }
    else
    {
        [_head setImage:[UIImage imageNamed:@"ic_tabbar_music"] forState:UIControlStateNormal];
    }
    _head.layer.cornerRadius=37.5;
    _head.layer.masksToBounds = YES;
    //[_head setBackgroundImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [emptyView addSubview:_head];
    
    //欢迎动画下面的动态字
    TOMSMorphingLabel *titleLabel = [[TOMSMorphingLabel alloc] initWithFrame:CGRectMake((emptyView.frame.size.width-110)/2, _head.frame.size.height+_head.frame.origin.y+15, 110.0f, 40.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"等待开放";
    titleLabel.font=[UIFont systemFontOfSize:18.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = UIColorFromRGB(0x999999);
    [emptyView addSubview:titleLabel];
    
    return emptyView;
}


+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {
        return CGSizeMake(800, 800 * height / width);
    } else {
        return CGSizeMake(800 * width / height, 800);
    }
}

+(NSString*)encodeURL:(UIImage *)image
{
     NSData *mydata=UIImageJPEGRepresentation(image , 0.4);
     NSString* string =[mydata base64Encoding];
     NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
     if (newString) {
        return newString;
     }
     return @"";
}

+(UIImage*)scaledToSize:(UIImage*) sourceImage toSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    UIGraphicsBeginImageContext(targetSize); // this will crop
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *) getYNRlTime{
    
    NSDate *  date=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  timeStr=[dateformatter stringFromDate:date];
    return timeStr;
}

+ (NSString *) getYNRDetailsTime{
    
    NSDate *  date=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *  timeStr=[dateformatter stringFromDate:date];
    return timeStr;
}

//十六进制颜色
+(UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString=[[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if(cString.length<6)
    {
        return [UIColor clearColor];
    }
    
    if([cString hasPrefix:@"0X"])
    {
        cString=[cString substringFromIndex:2];
    }
    if([cString hasPrefix:@"#"])
    {
        cString=[cString substringFromIndex:1];
    }
    if(cString.length!=6)
    {
        return [UIColor clearColor];
    }
    
    NSRange range;
    range.location=0;
    range.length=2;
    //r
    NSString *rString=[cString substringWithRange:range];
    //g
    range.location=2;
    NSString *gString=[cString substringWithRange:range];
    //b
    range.location=4;
    NSString *bString=[cString substringWithRange:range];
    
    unsigned int r,g,b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:1.0f];
}

-(NSString *)readFile{
    
    //创建文件管理器
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    
    //参数NSDocumentDirectory要获取那种路径
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];//去处需要的路径
    
    //更改到待操作的目录下
    
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    //获取文件路径
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"username"];
    
    NSData *reader = [NSData dataWithContentsOfFile:path];
    
    return [[NSString alloc] initWithData:reader encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSString *  timeStr=[date stringFromDate:d];
    return timeStr;
}

//格式手机号星号*
+(NSString *)FromatMobile:(NSString *)mobile
{
    NSMutableArray *codeArray=[[NSMutableArray alloc] init];
    for (int i=0; i<mobile.length; i++)
    {
        [codeArray addObject:[mobile substringWithRange:NSMakeRange(i, 1)]];
    }
    NSMutableString *resutCode=[[NSMutableString alloc] init];
    for(int i=0;i<codeArray.count;i++)
    {
        if(i>2 && i<codeArray.count-4)
        {
            [resutCode appendString:@"*"];
        }
        else
        {
            [resutCode appendString:codeArray[i]];
            
        }
    }
    return resutCode;
}
//合并两个数组并且去除重复元素,都是String类型
+(NSMutableArray *)FromatForStringArray:(NSMutableArray *)array1 arraywith:(NSMutableArray *)array2
{
    NSMutableArray* array3=[NSMutableArray arrayWithArray:array1];
    for(NSString* s in array1){
         NSLog(@"-------------1---%@----------",s);
        if([array2 containsObject:[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
            NSLog(@"----------------%@----------",s);
            [array2 removeObject:[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }
    [array3 addObjectsFromArray :array2];
    return array3;
}

@end
