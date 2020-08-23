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
    alert.cancelTitle = @"不同意";
    alert.sureTitle = @"同意";
    alert.title = @"用户服务协议及隐私政策";
    alert.alertViewDelegate = delegate;
    NSString *content = @"感谢您信任并使用准到服务，我们非常重视您的个人信息和隐私保护。依照新法律要求，我们更新了用户服务协议、隐私政策，请您务必仔细阅读《用户服务协议》和《隐私政策》，如您同意，请点击“同意”开始接受我们的服务";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    [attr addAttributes:@{NSLinkAttributeName: @"https://www.zhundao.net/service/help/detail/206"} range:[[attr string] rangeOfString:@"《用户服务协议》"]];
    [attr addAttributes:@{NSLinkAttributeName: @"https://www.zhundao.net/service/help/detail/207"} range:[[attr string] rangeOfString:@"《隐私政策》"]];
    alert.attributeContent = attr;
    alert.alertViewType = ZDServiceAlertViewTypePrivacyNormalAlert;
    alert.linkTextAttributes = @{NSForegroundColorAttributeName : ZDMainColor};
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert animationIn];
    return alert;
}

+ (instancetype)privacyNeedCheckAlertWithDelegate:(id)delegate  {
    ZDServiceAlertView *alert = [[ZDServiceAlertView alloc] init];
    alert.alertViewDelegate = delegate;
    alert.cancelTitle = @"我知道了";
    alert.title = @"隐私保护协议";
    alert.content = @"您需同意《用户服务协议》和《隐私政策》, 方可使用本软件";
    alert.onlyOneButton = YES;
    alert.alertViewType = ZDServiceAlertViewTypePrivacyNeedCheck;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [alert animationIn];
    return alert;
}

@end
