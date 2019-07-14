//
//  ShowViewModel.h
//  zhundao
//
//  Created by zhundao on 2017/9/28.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowViewModel : NSObject
/*! 保存textview的属性 */
- (void)saveData :(NSMutableDictionary *)dic
        textView :(UITextView *)textView;
/*! 保存二维码的属性 */
- (void)saveImageData :(NSMutableDictionary *)dic
            imageView :(UIImageView *)imageView;
/*! 保存如plist文件 */
- (void)savaToPlist :(NSArray *)fixArray
        customArray :(NSArray *)customArray
                 str:imageStr
               name :(NSString *)name;

/*! 读取fix数组 */
- (NSArray *)writeFixArray:(NSString *)name;
/*! 读取自定义数组 */
- (NSArray *)writeCustomArray :(NSString *)name;



/*! 编辑完成后 设置textview的frame */
- (void)setTextViewFrame :(UITextView *)textView;

@end
