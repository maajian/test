//
//  InfoEditViewModel.h
//  zhundao
//
//  Created by 罗程勇 on 2018/6/15.
//  Copyright © 2018年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoEditViewModel : NSObject

- (void)loginWirhCode:(NSString *)code phoneStr:(NSString *)phoneStr name:(NSString *)name passWord:(NSString *)passWord  successBlock:(kZDCommonSucc)successBlock failBlock:(kZDCommonFail)failBlock;

@end
