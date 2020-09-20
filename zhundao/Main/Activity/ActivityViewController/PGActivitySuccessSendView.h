//
//  PGActivitySuccessSendView.h
//  zhundao
//
//  Created by zhundao on 2017/11/9.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol successSendViewDeleagte<NSObject>

- (void)sureAction;

@end

@interface PGActivitySuccessSendView : UIView

@property(nonatomic,weak) id<successSendViewDeleagte> successSendViewDeleagte;

@end
