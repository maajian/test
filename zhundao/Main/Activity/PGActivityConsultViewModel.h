//
//  PGActivityConsultViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^getAllBlock) (NSArray *dataArray,NSArray *timeArray,NSArray *noAnswerArray,NSArray *hadAnswerArray);
@interface PGActivityConsultViewModel : NSObject


/*! 获取咨询列表 */
- (void)getAllConsult :(NSDictionary *)dic  getAllBlock:(getAllBlock)getAllBlock;

/*! 获取高度 */
- (NSArray *)getHeight:(NSArray *)array;

@end
