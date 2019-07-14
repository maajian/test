//
//  fontstyleView.h
//  zhundao
//
//  Created by zhundao on 2017/9/27.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol fontstyleDelegate <NSObject>
/*! 传字体 */
- (void)postFontstyle :(NSString *)fontstyle;

@end

@interface fontstyleView : UIView

/*! 字体界面初始化 */
- (instancetype)initWithFrame:(CGRect)frame fontstyle :(NSString * )fontstyle;

@property(nonatomic,strong) id<fontstyleDelegate>  fontstyleDelegate;

@property(nonatomic,copy)NSString *foneName;

@end
