//
//  ViewController.m
//  ScaleImageDemo
//
//  Created by zhangweiwei on 16/5/1.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "ViewController.h"
#import "ImageEditView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ImageEditView *imgEditVie;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.imgEditVie addWatermarkImage:[UIImage imageNamed:@"wm1"]];
    
    
    [self.imgEditVie addWatermarkImage:[UIImage imageNamed:@"wm2"]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

@end
