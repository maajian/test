//
//  listModel.h
//  zhundao
//
//  Created by zhundao on 2016/12/15.
//  Copyright © 2016年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModel : NSObject
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *Mobile;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,assign)NSInteger Status;
@end
