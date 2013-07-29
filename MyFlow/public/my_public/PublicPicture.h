//
//  PublicPicture.h
//  dbc
//  图片类，与图片操作有关的类
//  Created by CL7RNEC on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicPicture : NSObject
/*
 desc：截取当前视图为图像
 @param:paramView：需要截取的视图
 return:UIImage
 */
+(UIImage*)captureView:(UIView *)paramView;
/*
 desc：截取当前视图为图像
 @param:paramView：需要截取的视图
 @param:viewFrame：试图尺寸
 return:UIImage
 */
+(UIImage*)captureView:(UIView *)paramView
             viewFrame:(CGRect)viewFrame;
/*
 desc：从互联网获取图片
 @param:paramUrl：url地址
 return:UIImage
 */
+(UIImage *) getImageFromUrl:(NSString *) paramUrl;
/*
 desc：将图片保存到本地
 @param:image：要保存的图片
 @param:key：键值
 return:void
 */
+ (void)saveImageToLocal:(UIImage*)image Keys:(NSString*)key;
/*
 desc：判断本地是否有相关图片
 @param:key：键值
 return:BOOL
 */
+ (BOOL)localHaveImage:(NSString*)key;
/*
 desc：从本地获取图片
 @param:key：键值
 return:UIImage
 */
+ (UIImage*)getImageFromLocal:(NSString*)key;
@end
