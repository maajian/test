//
//  PGActivityBigImageCollectionView.h
//  zhundao
//
//  Created by zhundao on 2017/10/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol imageSelectDelegate <NSObject>

- (void)selectIndex :(NSString *)urlStr item :(NSInteger)item tag:(NSInteger)CollectionViewTag;

@end

@interface PGActivityBigImageCollectionView : UICollectionView
/*! 初始化 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout;

@property(nonatomic,weak) id<imageSelectDelegate> imageSelectDelegate;

/*! 数据源 */
@property(nonatomic,copy)NSArray *dataArray;
/*! 头视图标题 */
@property(nonatomic,copy,readwrite)NSString *headerTitle;
/*! 第几个item */
@property(nonatomic,assign)NSInteger currentItem;
/*! 第几个CollectionView */
@property(nonatomic,assign)NSInteger currentTag;

@end
