//
//  ZDConst.h
//  zhundao
//
//  Created by maj on 2019/5/27.
//  Copyright © 2019 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark --- notification

UIKIT_EXTERN NSString *const ZDNotification_Message_Select;
UIKIT_EXTERN NSString *const ZDNotification_Change_Account;
UIKIT_EXTERN NSString *const ZDNotification_Load_Activity;
UIKIT_EXTERN NSString *const ZDNotification_Network_Change;
UIKIT_EXTERN NSString *const ZDNotification_Logout;
UIKIT_EXTERN NSString *const ZDNotification_Push; // 推送消息
UIKIT_EXTERN NSString *const ZDNotification_UnreadMessageChange; // 未读消息更新红点数据变化
UIKIT_EXTERN NSString *const ZDNotification_GetMessageList; // 消息列表获取

#pragma mark --- NSUserDefaults
UIKIT_EXTERN NSString *const ZDUserDefault_First_Network;
UIKIT_EXTERN NSString *const ZDUserDefault_Network_Line;
UIKIT_EXTERN NSString *const ZDUserDefault_Sign_Mark;
UIKIT_EXTERN NSString *const ZDUserDefault_Update_Sign;
UIKIT_EXTERN NSString *const ZDUserDefault_HasShowPrivacy;
UIKIT_EXTERN NSString *const ZDUserDefault_LoginTime;
UIKIT_EXTERN NSString *const ZDUserDefault_ClientId; // 客户端clientID
UIKIT_EXTERN NSString *const ZDUserDefault_UnreadMessage; // 未读消息个数
 
#pragma mark --- Cache
UIKIT_EXTERN NSString *const ZDCacheSign_One_List;
