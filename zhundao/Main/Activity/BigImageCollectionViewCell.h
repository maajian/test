//
//  BigImageCollectionViewCell.h
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigImageCollectionViewCell : UICollectionViewCell
/*! 图片 */
@property(nonatomic,strong)UIImageView *bigImageView;

@property(nonatomic,copy)NSString *imageStr;

@end
