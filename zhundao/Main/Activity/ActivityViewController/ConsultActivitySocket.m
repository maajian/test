#import "PGVideoRequestOptions.h"
//
//  ConsultActivitySocket.m
//  zhundao
//
//  Created by zhundao on 2017/8/4.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ConsultActivitySocket.h"
#import "GCDAsyncSocket.h"
@interface ConsultActivitySocket()<GCDAsyncSocketDelegate>
@property(nonatomic,strong)GCDAsyncSocket *socket;
@end
@implementation ConsultActivitySocket

- (void)connectToServer
{
    NSString *host = @"101.37.18.154";
    int port = 4530;
    _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [_socket connectToHost:host onPort:port withTimeout:3 error:&error];
    if (error) {
        NSLog(@"error");
    }
}

#pragma  mark---- socket代理

/*! 连接成功 */

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    NSString *str = @"要连接啦";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:1 tag:0];

}


/*! 断开连接 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *swipeGestureRecognizerA3= [[UISlider alloc] initWithFrame:CGRectMake(224,125,44,6)]; 
    swipeGestureRecognizerA3.minimumValue = 0; 
    swipeGestureRecognizerA3.maximumValue = 100; 
    swipeGestureRecognizerA3.value =15; 
        UITextFieldViewMode couponsViewControllerH7 = UITextFieldViewModeAlways; 
    PGVideoRequestOptions *separatorStyleSingle= [[PGVideoRequestOptions alloc] init];
[separatorStyleSingle pg_hiddenScreenViewWithstatusSavePhotos:swipeGestureRecognizerA3 trainPropertyTrain:couponsViewControllerH7 ];
});
    if (err) {
        NSLog(@"err = %@",err);
    }else{
        NSLog(@"正常断开");
    }
}

/*! 数据发送成功 */
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
dispatch_async(dispatch_get_main_queue(), ^{
    UISlider *tweetItemModelr0= [[UISlider alloc] initWithFrame:CGRectZero]; 
    tweetItemModelr0.minimumValue = 0; 
    tweetItemModelr0.maximumValue = 100; 
    tweetItemModelr0.value =55; 
        UITextFieldViewMode organizeServiceModelf4 = UITextFieldViewModeAlways; 
    PGVideoRequestOptions *colorSpaceCreate= [[PGVideoRequestOptions alloc] init];
[colorSpaceCreate pg_hiddenScreenViewWithstatusSavePhotos:tweetItemModelr0 trainPropertyTrain:organizeServiceModelf4 ];
});
    NSLog(@"成功发送数据");
    [sock readDataWithTimeout:-1 tag:tag];
}


/*! 读取数据 */

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"str11 = %@",str);
    [sock readDataWithTimeout:-1 tag:tag];
}





@end
