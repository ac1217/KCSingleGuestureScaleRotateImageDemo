//
//  UITextView+KCExtension.m
//  categoryDemo
//
//  Created by zhangweiwei on 16/5/17.
//  Copyright © 2016年 Erica. All rights reserved.
//

#import "UITextView+KCExtension.h"
#import <objc/message.h>

static NSString *const KCTextViewPlaceholderLabelKey = @"kc_textViewPlaceholderLabel";

@interface UITextView ()
@property (nonatomic, strong) UILabel *kc_placeholderLabel;
@end

@implementation UITextView (KCExtension)

- (UILabel *)kc_placeholderLabel
{
    UILabel *placeholderLabel = objc_getAssociatedObject(self, (__bridge const void *)(KCTextViewPlaceholderLabelKey));
    if (!placeholderLabel) {
        placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.font = self.font;
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        objc_setAssociatedObject(self, (__bridge const void *)(KCTextViewPlaceholderLabelKey), placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        CGFloat H = self.textContainer.lineFragmentPadding + self.textContainerInset.left;
        CGFloat V = self.textContainerInset.top;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:H]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:V]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:placeholderLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:H * -2]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kc_textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return placeholderLabel;

}

+ (void)load
{
    Method dealloc1 = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method dealloc2 = class_getInstanceMethod(self, @selector(kc_dealloc));
    
    method_exchangeImplementations(dealloc1 , dealloc2);
    
    Method font1 = class_getInstanceMethod(self, @selector(setFont:));
    Method font2 = class_getInstanceMethod(self, @selector(kc_setFont:));
    
    method_exchangeImplementations(font1 , font2);
    
    Method text1 = class_getInstanceMethod(self, @selector(setText:));
    Method text2 = class_getInstanceMethod(self, @selector(kc_setText:));
    
    method_exchangeImplementations(text1 , text2);
    
    
    Method attrText1 = class_getInstanceMethod(self, @selector(setAttributedText:));
    Method attrText2 = class_getInstanceMethod(self, @selector(kc_setAttributedText:));
    
    method_exchangeImplementations(attrText1 , attrText2);
}

- (void)kc_dealloc
{
    [self kc_dealloc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)kc_setAttributedText:(NSAttributedString *)attrText
{
    [self kc_setAttributedText:attrText];
    
    [self kc_textChange];
}

- (void)kc_setText:(NSString *)text
{
    [self kc_setText:text];
    
    [self kc_textChange];
}

- (void)kc_setFont:(UIFont *)font
{
    [self kc_setFont:font];
    
    self.kc_placeholderLabel.font = font;
    
}

- (void)setKc_placeholder:(NSString *)kc_placeholder
{
    
    self.kc_placeholderLabel.text = kc_placeholder;

}

- (void)kc_textChange
{
    self.kc_placeholderLabel.hidden = self.hasText;
}

- (NSString *)kc_placeholder
{
    return self.kc_placeholderLabel.text;
}

- (void)setKc_placeholderColor:(UIColor *)kc_placeholderColor
{
    [self.kc_placeholderLabel setTextColor:kc_placeholderColor];
}

- (UIColor *)kc_placeholderColor
{
    return [self.kc_placeholderLabel textColor];
}



@end
