//
//  PGTextStyle.m
//  SimpleWord
//
//  Created by Chenly on 16/5/14.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "PGTextStyle.h"
#import "UIFont+LMText.m"

@interface PGTextStyle ()

@end

@implementation PGTextStyle

- (instancetype)init {
    if (self = [super init]) {
        _fontSize = 16.f;
        _textColor = [UIColor blackColor];
    }
    return self;
}

+ (instancetype)textStyleWithType:(LMTextStyleType)type {
    
    PGTextStyle *textStyle = [[self alloc] init];
    switch (type) {
        case LMTextStyleFormatTitleSmall:
            textStyle.fontSize = 18.f;
            break;
        case LMTextStyleFormatTitleMedium:
            textStyle.fontSize = 24.f;
            break;
        case LMTextStyleFormatTitleLarge:
            textStyle.fontSize = 30.f;
            break;
        default:
            return textStyle;
    }
    textStyle.bold = type == LMTextStyleFormatNormal ? NO : YES;
    return textStyle;
}

#pragma mark - setter & getter

- (LMTextStyleType)type {
    if (self.bold == YES && self.italic == NO && self.underline == NO) {
        if (self.fontSize == 18.f) {
            return LMTextStyleFormatTitleSmall;
        }
        else if (self.fontSize == 24.f) {
            return LMTextStyleFormatTitleMedium;
        }
        else if (self.fontSize == 30.f) {
            return LMTextStyleFormatTitleLarge;
        }
    }
    return LMTextStyleFormatNormal;
}

- (UIFont *)font {
    return [UIFont lm_fontWithFontSize:self.fontSize bold:self.bold italic:self.italic];
}

@end
