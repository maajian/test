//
//  MyImage.h
//  zhundao
//
//  Created by zhundao on 2017/2/22.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyImage : UIImageView
+(UIImageView *)initWithImageFrame:(CGRect)frame imageName:(NSString *)imageName cornerRadius :(float)cornerRadius masksToBounds:(BOOL)masksToBounds;
@end
