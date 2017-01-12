//
//  SignManager.h
//  zhundao
//
//  Created by zhundao on 2016/12/20.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface SignManager : NSObject
{
  
}
@property(nonatomic,copy)NSString *accesskey;
@property(nonatomic,strong)FMDatabase *dataBase;
+(SignManager *)shareManager;
- (NSString *)getaccseekey;
- (void)createDatabase;

@end
