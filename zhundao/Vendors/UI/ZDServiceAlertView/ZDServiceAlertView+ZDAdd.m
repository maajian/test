//
//  ZDServiceAlertView+ZDAdd.m
//  zhundao
//
//  Created by maj on 2020/1/14.
//  Copyright © 2020 zhundao. All rights reserved.
//

#import "ZDServiceAlertView+ZDAdd.h"


@implementation ZDServiceAlertView (ZDAdd)

+ (instancetype)privacyAlertWithDelegate:(id)delegate {
    ZDServiceAlertView *alert = [[ZDServiceAlertView alloc] init];
    alert.alertViewDelegate = delegate;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert animationIn];
    return alert;
}

@end
