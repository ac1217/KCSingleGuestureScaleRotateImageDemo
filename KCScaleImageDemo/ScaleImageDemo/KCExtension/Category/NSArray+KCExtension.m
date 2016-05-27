//
//  NSArray+KCExtension.m
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/6.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "NSArray+KCExtension.h"

@implementation NSArray (KCExtension)

#pragma mark -log
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"[\n"];
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    [str appendString:@"]"];
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    return str;
}

#pragma mark -元素顺序
// 数组元素倒序
- (instancetype)kc_descendingObjects
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSInteger i = self.count - 1; i >= 0; i--) {
        id obj = self[i];
        [temp addObject:obj];
    }
    return temp;
}


@end
