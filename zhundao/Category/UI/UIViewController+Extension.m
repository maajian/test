//
//  UIViewController+Extension.m
//  jingjing
//
//  Created by maj on 2020/8/5.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (BOOL)ZD_isTop {
    if (self.navigationController) {
        return self.navigationController.topViewController == self;
    }
    return NO;
}

@end
