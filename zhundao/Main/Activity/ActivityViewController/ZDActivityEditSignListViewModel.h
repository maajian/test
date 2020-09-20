//
//  ZDActivityEditSignListViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/6/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^postBlock) (NSInteger isSuccess);



@interface ZDActivityEditSignListViewModel : NSObject
@property(nonatomic,copy) postBlock postBlock;

//网络请求
- (void)postDataWithDic :(NSDictionary *)dic ;

//获取必填项
- (NSMutableArray *)getMustArrayFromArray :(NSArray *)baseNameArray
                              customArray :(NSArray *)customArray ;

- (NSMutableArray *)getRequiredArray :(NSArray *)baseArray allOptionArray :(NSArray *)allOptionArray;



//获取右边必填项
- (NSMutableArray *)getRightMustArray :(NSArray *)baseArray
                       allOptionArray :(NSArray *)allOptionArray
                                  dic :(NSDictionary *)optionDic ;


//获取必填项的type
-(NSMutableArray *)getMustInputTypeFromArray :(NSArray *)baseNameArray
                                 customArray :(NSArray *)customArray;



//获取必填项英文
- (NSMutableArray *)getLastPostArray :(NSArray *)array;

//将json字符串改变为字典
- (NSDictionary *)getDicWithStr :(NSString *)jsonStr ;

//为*添加富文本变红色
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text ;

//通过type设置键盘类型
- (void)setKeyboardTypeWithtextf : (UITextField *)textf
                            type :(NSInteger) type ;

 //获取多选 单选 下拉 框的所有选项
- (NSArray *)getAllChooseArrayWithStr :(NSString *)titleStr
                           customArray:(NSArray *)customArray;

//获取当前选择的选项
- (NSArray *)getNowChooseArrayWithStr :(NSString *)titleStr ;

- (NSDictionary *)SaveWithRightMustArray :(NSMutableArray *)rightMustArray
                 leftMustArray :(NSMutableArray *)_leftMustArray
                               baseArray :(NSArray *)baseArray
                          view :(UIView *)view;


//根据名称和选择的性别 选择index 0 1 2
- (NSInteger )getSexSelectStr :(NSString *)sexStr;

//获取右边基础必填项
- (NSMutableArray *)getBaseRightArray :(NSArray *)allRight count :(NSInteger )count;
@end
