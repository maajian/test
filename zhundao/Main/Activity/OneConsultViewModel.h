//
//  OneConsultViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/8/3.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^postBlock) (BOOL isSuccess);
@interface OneConsultViewModel : NSObject


/*!
 *   发送回复留言
  *  ConsultID     ：咨询ID
  *  answer。       ：回复内容
  *  IsRecommend    ：是否推荐
 */
- (void)postData:(NSInteger)ConsultID answer :(NSString *)answer IsRecommend :(BOOL)IsRecommend postBlock:(postBlock)postBlock;

/*!  
 *    获取自定义高度
 *   str :  字符串
 *   width :固定的宽度
 */
- (float)getHeight:(NSString *)str width :(float)width;

@end
