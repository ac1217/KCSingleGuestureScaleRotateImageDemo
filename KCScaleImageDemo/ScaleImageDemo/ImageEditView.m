//
//  ImageEditView.m
//  ScaleImageDemo
//
//  Created by zhangweiwei on 16/5/1.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "ImageEditView.h"

#import "KCExtension.h"

@interface ImageEditView ()<UIGestureRecognizerDelegate>
{
    UIImageView *_imageView;
}
@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, weak) UIImageView *currentEditintImageView;

@property (nonatomic, weak) UIButton *deleteBtn;

@property (nonatomic, weak) UIImageView *editBtn;

@property (nonatomic, assign) CGPoint previousPoint;


@property (nonatomic, assign, getter=isEditGusture) BOOL editGusture;


@end

@implementation ImageEditView

#pragma mark -懒加载


- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self insertSubview:imageView atIndex:0];
    }
    return _imageView;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        UIButton *deleteBtn = [[UIButton alloc] init];
        [deleteBtn addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [deleteBtn setImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
        deleteBtn.hidden = YES;
        [self addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
}

- (void)delete
{
    [self.currentEditintImageView removeFromSuperview];
    [self.imageViews removeObject:self.currentEditintImageView];
    self.currentEditintImageView = nil;
    [self hideEditingBtn:YES];
}

- (UIImageView *)editBtn
{
    if (!_editBtn) {
        UIImageView *editBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_watermark_scale"]];
        editBtn.contentMode = UIViewContentModeCenter;
        editBtn.userInteractionEnabled = NO;
        editBtn.hidden = YES;
        [self addSubview:editBtn];
        
        
        _editBtn = editBtn;
    }
    return _editBtn;
}

- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setup];
    }
    return self;
}

#pragma mark -初始化
- (void)setup
{
    self.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
    
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    rotate.delegate = self;
    [self addGestureRecognizer:rotate];
    
    
}

#pragma mark -手势
- (void)rotate:(UIRotationGestureRecognizer *)rotate
{
    if (!self.currentEditintImageView) {
        
        self.currentEditintImageView = [self imageViewInLocation:[rotate locationInView:self]];
        if (!self.currentEditintImageView) return;
    }
    
    if (rotate.state == UIGestureRecognizerStateBegan) {
        
        [self hideEditingBtn:YES];
    }else if (rotate.state == UIGestureRecognizerStateEnded) {
        
        if (!self.currentEditintImageView) return;
        [self hideEditingBtn:NO];
    }else {
        
        self.currentEditintImageView.transform = CGAffineTransformRotate(self.currentEditintImageView.transform, rotate.rotation);
        
        [rotate setRotation:0];
        
    }
//    [self resetBorder];
}



- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    
    if (pinch.state == UIGestureRecognizerStateBegan) {
        
        UIImageView *imgView = [self imageViewInLocation:[pinch locationInView:self]];
        if (!self.currentEditintImageView && !imgView) return;
        
        if (imgView) {
            self.currentEditintImageView = imgView;
        }
        
        [self hideEditingBtn:YES];
    }else if (pinch.state == UIGestureRecognizerStateEnded) {
        if (!self.currentEditintImageView) return;
        [self hideEditingBtn:NO];
    }else {
        
        self.currentEditintImageView.transform = CGAffineTransformScale(self.currentEditintImageView.transform, pinch.scale, pinch.scale);
        
        [pinch setScale:1];
        
    }
    
//    [self resetBorder];
    
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *imgView = [self imageViewInLocation:[tap locationInView:self]];
    
    self.currentEditintImageView = imgView;
    
    [self hideEditingBtn:!imgView];
    
//    [self resetBorder];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        UIImageView *imgView = [self imageViewInLocation:[pan locationInView:self]];
        if (!self.currentEditintImageView && !imgView) return;
        
        if (imgView) {
            self.currentEditintImageView = imgView;
        }
        
        CGPoint loc = [pan locationInView:self];
        self.editGusture = CGRectContainsPoint(self.editBtn.frame, loc);
        [self hideEditingBtn:YES];
        
        self.previousPoint = loc;
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (!self.currentEditintImageView) return;
        
        [self hideEditingBtn:NO];
        
        self.previousPoint = [pan locationInView:self];
        
    }else {
        
        if (self.isEditGusture) {
            
            // 拖拽编辑按钮处理
            
            CGPoint currentTouchPoint = [pan locationInView:self];
            CGPoint center = self.currentEditintImageView.center;
            
            CGFloat angleInRadians = atan2f(currentTouchPoint.y - center.y, currentTouchPoint.x - center.x) - atan2f(self.previousPoint.y - center.y, self.previousPoint.x - center.x);
            
            CGAffineTransform t = CGAffineTransformRotate(self.currentEditintImageView.transform, angleInRadians);
            
            CGFloat previousDistance = [self distanceWithPoint:center otherPoint:self.previousPoint];
            CGFloat currentDistance = [self distanceWithPoint:center otherPoint:currentTouchPoint];
            
            CGFloat scale = currentDistance / previousDistance;
            
            t = CGAffineTransformScale(t, scale, scale);
            
            self.currentEditintImageView.transform = t;
            
        }else {
            
            if (!self.currentEditintImageView) return;
            
            CGPoint t = [pan translationInView:self.currentEditintImageView];
            
            self.currentEditintImageView.transform = CGAffineTransformTranslate(self.currentEditintImageView.transform, t.x, t.y);
            
            [pan setTranslation:CGPointZero inView:self.currentEditintImageView];
        }
        
        self.previousPoint = [pan locationInView:self];
        
    }
//    [self resetBorder];
    
//    CGRect rect = CGRectApplyAffineTransform(self.currentEditintImageView.frame, self.currentEditintImageView.transform);
//    NSLog(@"%@", NSStringFromCGRect(rect));
}


#pragma mark -私有方法

- (UIImageView *)imageViewInLocation:(CGPoint)loc
{
    
    for (UIImageView *imgView in self.imageViews) {
        
        if (CGRectContainsPoint(imgView.frame, loc)) {
            
            [self bringSubviewToFront:imgView];
            
            return imgView;
        }
        
    }
    
    return nil;
    
}


- (void)hideEditingBtn:(BOOL)hidden
{
    self.deleteBtn.hidden = hidden;
    self.editBtn.hidden = hidden;
    
    if (!hidden) {
        
        self.deleteBtn.center = self.currentEditintImageView.kc_topLeftAfterTransform;
        
        self.editBtn.center = self.currentEditintImageView.kc_bottomRightAfterTransform;
        
    }
    
}


- (CGFloat)distanceWithPoint:(CGPoint)point otherPoint:(CGPoint)otherPoint
{
    return sqrt(pow(point.x - otherPoint.x, 2) + pow(point.y - otherPoint.y, 2));
    
    
}

#pragma mark -系统方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnWH = 40;
    self.deleteBtn.bounds = CGRectMake(0, 0, btnWH, btnWH);
    self.editBtn.bounds = CGRectMake(0, 0, btnWH, btnWH);
    
    if (self.imageView.image.size.width < self.kc_width && self.imageView.image.size.height < self.kc_height) {
        
        self.imageView.kc_size = self.imageView.image.size;
        self.imageView.center = CGPointMake(self.kc_width * 0.5, self.kc_height * 0.5);
    }else {
        
            CGFloat w = 0;
            CGFloat h = 0;
            
            if (self.imageView.image.size.width < self.imageView.image.size.height) {
                
                h = self.kc_height;
                w = h * self.imageView.image.size.width / self.imageView.image.size.height;
                
            }else {
                
                w = self.kc_width;
                h = w * self.imageView.image.size.height / self.imageView.image.size.width;
            }
            
            
            self.imageView.kc_size = CGSizeMake(w, h);
            self.imageView.kc_center = CGPointMake(self.kc_width * 0.5, self.kc_height * 0.5);
        }
   
}


#pragma mark -公共方法

- (void)addWatermarkImage:(UIImage *)watermarkImage
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:watermarkImage];
    imageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    [self addSubview:imageView];
    
    [self.imageViews addObject:imageView];
    
    
}


- (void)endEditing
{
    self.currentEditintImageView = nil;
    
    [self hideEditingBtn:YES];
    
//    [self resetBorder];
    
}

#pragma mark -UIGestureDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
