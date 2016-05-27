//
//  KCMacro.h
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/6.
//  Copyright © 2016年 Erica. All rights reserved.
//

#ifndef KCMacro_h
#define KCMacro_h

// 颜色相关宏
#define KC_RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KC_RGB_COLOR(r,g,b) KC_RGBA_COLOR(r,g,b,1)
#define KC_RANDOM_COLOR KC_RGB_COLOR(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#define KC_HEX_COLOR(hexValue) [UIColor kc_colorWithHexValue:hexValue]

// 字体相关
#define KC_SYSTEM_FONT_SIZE(size) [UIFont systemFontOfSize:size]

// 单例宏
#define KC_NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]
#define KC_APPLICATION [UIApplication shareApplication]
#define KC_USER_DEFAULTS [NSUserDefaults standardUserDefaults]

// 通知相关宏
#define KC_REMOVE_NOTIFICATION [KC_NOTIFICATION_CENTER removeObserver:self];
#define KC_POST_NOTIFICATION(name,obj,info) [KC_NOTIFICATION_CENTER  postNotificationName:name object:obj userInfo:info];


// 系统版本，设备相关
#define KC_SYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
#define KC_IS_IOS8 [KC_SYSTEM_VERSION floatValue] >= 8.0
#define KC_IS_IOS9 [KC_SYSTEM_VERSION floatValue] >= 9.0

// 屏幕相关
#define KC_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define KC_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 不同屏幕比例，以375 * 667为基准
#define KC_HORIZONTAL_RATIO KC_SCREEN_WIDTH / 375
#define KC_VERTICAL_RATIO KC_SCREEN_HEIGHT / 667


//弱引用
#define KC_WEAK_REFERENCE(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//KCLog日志输出方法

#ifdef DEBUG
#define KCLog(...) NSLog(__VA_ARGS__)
#else
#define KCLog(...)
#endif

#endif /* KCMacro_h */
