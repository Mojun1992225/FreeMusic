//
//  Tools.h
//  360VIPManager
//
//  Created by guo on 15/8/14.
//  Copyright (c) 2015年 中超 曹. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  eighteenFont  [UIFont fontWithName:@"Arial" size:18.0]
#define  seventeenFont  [UIFont fontWithName:@"Arial" size:17.0]
#define  sixteenFont  [UIFont fontWithName:@"Arial" size:16.0]
#define  fifteenFont  [UIFont fontWithName:@"Arial" size:15.0]
#define  fourteenFont  [UIFont fontWithName:@"Arial" size:14.0]
#define  thirteenFont  [UIFont fontWithName:@"Arial" size:13.0]
#define  twelveFont  [UIFont fontWithName:@"Arial" size:13.0]
#define  tenFont  [UIFont fontWithName:@"Arial" size:10.0]


#define  Bold_SeventeenFont   [UIFont fontWithName:@"Helvetica-Bold" size:17]
#define  Bold_SixteenFont   [UIFont fontWithName:@"Helvetica-Bold" size:16]

@interface Tools : NSObject

//+ (CGSize) getRCLabelCGSize:(RCLabel *) rcLabel  fontSize:(UIFont *) font  content:(NSString *) data;

+ (UIView*)getEmptyView;

+ (UIView*)getEmptyView1;

+ (UIView*)getEmptyView2;

+(NSString*)encodeURL:(UIImage *)image;

+ (NSString*) base64Encode:(NSData *)data;

+(UIImage*)scaledToSize:(UIImage*) sourceImage toSize:(CGSize)targetSize;

+ (NSString *) getYNRlTime; //获得年月日

+ (NSString *) getYNRDetailsTime; //获得年月日
//十六进制颜色
+(UIColor *)colorWithHexString:(NSString *)color;

//格式手机号星号*
+(NSString *)FromatMobile:(NSString *)mobile;

//合并两个数组并且去除重复元素,都是String类型
+(NSMutableArray *)FromatForStringArray:(NSMutableArray *)array1 arraywith:(NSMutableArray *)array2;
@end
