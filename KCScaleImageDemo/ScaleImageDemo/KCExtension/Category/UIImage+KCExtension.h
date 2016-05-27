//
//  UIImage+KCExtension.h
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/6.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KCExtension)
/*
 * 调整image方向
 */
- (UIImage *)kc_fixOrientation;

/*
 * 图片颜色设置
 */
// 渲染某种颜色到整张图片中
- (UIImage *)kc_renderImageWithColor:(UIColor *)color level:(CGFloat)level;
// 获取某种颜色的纯色图片
// 返回1x1大小
+ (UIImage *)kc_pureColorimageWithColor:(UIColor *)color;
// 指定大小
+ (UIImage *)kc_pureColorimageWithColor:(UIColor *)color size:(CGSize)size;

/*
 * 图片剪切缩放
 */
// 圆角图片
- (UIImage *)kc_roundedImageWithCornerRadius:(CGFloat)cornerRadius;
// 圆形图片
- (UIImage *)kc_circleImage;
// 根据比例缩放图片
- (UIImage *)kc_imageWithScale:(CGFloat)scale;
// 指定宽度根据宽高比计算
- (UIImage *)kc_imageWithWidth:(CGFloat)width;
// 指定size
- (UIImage *)kc_imageWithSize:(CGSize)size;

@end
