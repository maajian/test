//
//  ShareView.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/23.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "ShareView.h"
#import "UIView+TYAlertView.h"
#import "WXApi.h"
@implementation ShareView
- (IBAction)cancelAction:(id)sender {
 
    [self hideView];
}


- (IBAction)shareToWeixin:(id)sender {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = _model.Title;
//        message.description = [NSString stringWithFormat:@"活动时间:%@ 地点:%@",_model.TimeStart,_model.Address];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.ShareImgurl]]];
        [message setThumbImage:image];
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl =[NSString stringWithFormat:@"m.zhundao.net/event/%li",(long)_model.ID];//分享链接
        message.mediaObject = webObj;
        sendReq.message = message;
           [WXApi sendReq:sendReq];
        
    }
    else
    {
        [self setupAlertController];
    }
}
- (IBAction)shareToFriend:(id)sender {
    if ([WXApi isWXAppInstalled]) {
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;//不使用文本信息
        sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = _model.Title;
        message.description = [NSString stringWithFormat:@"活动时间:%@ 地点:%@",_model.TimeStart,_model.Address];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_model.ShareImgurl]]];
        [message setThumbImage:image];
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl =[NSString stringWithFormat:@"m.zhundao.net/event/%li",(long)_model.ID];//分享链接
        message.mediaObject = webObj;
        sendReq.message = message;
        [WXApi sendReq:sendReq];
     
    }
   else
   {
       [self setupAlertController];
   }
}
- (void)awakeFromNib
{
    [super awakeFromNib];
  
}
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self.viewController presentViewController:alert animated:YES completion:nil];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/

@end
