//
//  MJNoDataScrollView.h
//  zhundao
//
//  Created by zhundao on 2017/8/7.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^reloadBlock) (BOOL isReload);

/*! 占位图的类型 */
typedef NS_ENUM(NSInteger,showType) {
    /*! 没有网络 */
    NoNetWork = 0 ,
    /*! 有网络但是数据为空 */
    HavaNetButNotData = 1
};


@interface MJNoDataScrollView : UIScrollView

@property(nonatomic,copy)reloadBlock reloadBlock1;
/*! 初始化创建 */
- (instancetype)initWithFrame:(CGRect)frame
                   imageName :(NSString *)imageName
                     topText :(NSString *) topText
                  bottomText :(NSString *) bottomText;
/*! 移除视图 */
- (void) removeNoDataView;
/*! 给屏幕添加点击刷新的手势 */
- (void)addGesToScreenWithBlock :(SEL)reloadSEL;
/*! 重新设置内容 */
- (void)setData  :(NSString *)imageName
         topText :(NSString *) topText
      bottomText :(NSString *) bottomText;

@end
