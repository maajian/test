//
//  inviteCollectionView.h
//  zhundao
//
//  Created by zhundao on 2017/8/30.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol inviteDelegate <NSObject>

- (void)selectIndex  :(NSInteger) index ;

- (void)dismissVC;

@end

@interface inviteCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout imageArray :(NSArray *)imageArray View : (UIView *)View;

@property(nonatomic,weak) id<inviteDelegate> inviteDelegate;

@end
