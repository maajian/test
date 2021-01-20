//
//  ZDDeviceManager.h
//  zhundao
//
//  Created by maj on 2021/1/7.
//  Copyright © 2021 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZD_DeviceM [ZDDeviceManager sharedDeviceManager]

NS_ASSUME_NONNULL_BEGIN

@interface ZDDeviceManager : NSObject
ZD_Singleton_Interface(DeviceManager)

- (NSString *)getPhoneName;
- (NSString *)getDeviceUUID;
- (NSString *)getSystemVersion;
- (NSString *)getSystemName;
- (NSString *)getDeviceName;

@end

NS_ASSUME_NONNULL_END
