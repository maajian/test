//
//  PGDiscoverPrintVM.h
//  zhundao
//
//  Created by zhundao on 2017/6/29.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGDiscoverPrintVM : NSObject

//  去除cell的选择
- (void)checkWithboolArray :(NSMutableArray *)boolArray
                  tableView:(UITableView *)tableView
                   section :(NSInteger)section;

//重新设置cell 的bool数组
- (NSMutableArray *)changeArray :(NSMutableArray *)array
                            row :(NSInteger )row;

//打印字符串
- (void)printTextIsPrint :(BOOL)isPrint
                 offsetx :(int )x
                 offsety :(int)y
               textArray :(NSArray *)textArray;

//  打印二维码
- (void)printQRCode :(NSString *)linkStr
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y;

//打印二维码和姓名
- (void)printQRCode :(NSString *)linkStr
               name :(NSString *)name
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y;
/*! 打印二维码 + 备注 */
- (void)printQRCode :(NSString *)linkStr
            isPrint :(BOOL)isPrint
            offsetx :(int )x
            offsety :(int)y
          textArray :(NSArray *)textArray;
//获得size数组
//- (NSArray *)getSize;

//模版数组
- (NSArray *)getModel;

//触发模式数组
- (NSArray *)getActive;

//获取偏移值x
- (NSString *)getOffsetX;

//获取偏移值y
- (NSString *)getOffsetY;

//获取是否打印
- (BOOL)getFlag;
@end
