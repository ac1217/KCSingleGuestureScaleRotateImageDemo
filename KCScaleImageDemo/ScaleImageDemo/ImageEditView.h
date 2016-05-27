//
//  ImageEditView.h
//  ScaleImageDemo
//
//  Created by zhangweiwei on 16/5/1.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditView : UIView

@property (nonatomic, weak, readonly) UIImageView *imageView;


- (void)addWatermarkImage:(UIImage *)watermarkImage;

- (void)endEditing;



@end
