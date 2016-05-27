//
//  UIView+KCExtension.h
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/6.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KCExtension)
/*
 * 快速设置frame、center、size
 */
@property (nonatomic, assign) CGFloat kc_x;
@property (nonatomic, assign) CGFloat kc_y;
@property (nonatomic, assign) CGFloat kc_maxX;
@property (nonatomic, assign) CGFloat kc_maxY;
@property (nonatomic, assign) CGFloat kc_centerX;
@property (nonatomic, assign) CGFloat kc_centerY;
@property (nonatomic, assign) CGFloat kc_width;
@property (nonatomic, assign) CGFloat kc_height;
@property (nonatomic, assign) CGSize kc_size;
@property (nonatomic, assign) CGPoint kc_center;

/*
 * transform后获取四个点真实坐标
 */
// 原来的frame
-(CGRect)kc_originalFrameAfterTransform;
// 以下为4个点坐标
-(CGPoint)kc_topLeftAfterTransform;
-(CGPoint)kc_topRightAfterTransform;
-(CGPoint)kc_bottomLeftAfterTransform;
-(CGPoint)kc_bottomRightAfterTransform;

/*
 * 截取view上正在显示的内容
 */
// 整个view内容截取
- (UIImage *)kc_screenshot;
// 指定区域截取
- (UIImage *)kc_screenshotWithRect:(CGRect)rect;

/*
 * 快速创建分割线view
 */
// 白色分割线
+ (instancetype)kc_whiteSeparator;
// 黑色分割线
+ (instancetype)kc_blackSeparator;

/*
 * 加载XIB
 */
// 从xib加载view
+ (instancetype)kc_viewFromXib;
// 获取view的xib对象
+ (UINib *)kc_xib;

/*
 * 显示红点, 默认在右上角
 */
@property (nonatomic, copy) NSString *kc_badgeValue;
- (void)kc_setBadgeValue:(NSString *)badgeValue offset:(CGPoint)offset;

/*
 * 图层相关
 */
@property (nonatomic, strong) UIColor *kc_layerBackgroundColor;
@property (nonatomic, strong) UIColor *kc_layerBorderColor;
@property (nonatomic, assign) CGFloat kc_layerBorderWidth;
@property (nonatomic, assign) CGFloat kc_layerCornerRadius;

- (void)kc_setLayerCornerRadiusWithClips:(CGFloat)cornerRadius;

@end
