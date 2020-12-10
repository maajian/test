//
//  ZDBaseSubVC.h
//  Meari
//
//  Created by 李兵 on 2016/11/18.
//  Copyright © 2016年 PPStrong. All rights reserved.
//

@interface ZDBaseSubVC : BaseViewController<UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableDictionary *dataSourceDic;

//InitSet
@property (nonatomic, copy) ZDBlock_TableView setTableView;

@property (nonatomic, assign) BOOL isError;
@property (nonatomic, assign) BOOL showErrorImage;
@property (nonatomic, copy) NSString *errorTitle;
@property (nonatomic, copy) NSAttributedString *attributedErrorTitle;
@property (nonatomic, copy) NSAttributedString *errorDescription;
@property (nonatomic, strong) UIImage *errorImage;
@property (nonatomic, strong) UIImage *errorImageLoading;

@property (nonatomic, copy) ZDBlock_Void errorViewWillAppearBlock;
@property (nonatomic, copy) ZDBlock_Void errorViewDidAppearBlock;
@property (nonatomic, copy) ZDBlock_Void errorViewWillDisappearBlock;
@property (nonatomic, copy) ZDBlock_Void errorViewDidDisappearBlock;
@property (nonatomic, copy) ZDBlock_Void errorViewTapedBlock;
@property (nonatomic, copy) ZDBlock_Void errorButtonTapedBlock;
@property (nonatomic, copy) ZDBlock_Void errorBlock;
@property (nonatomic, copy) ZDBlock_Str errorBlockWithError;

//Empty 属性
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL showEmptyImage;
@property (nonatomic, copy) NSString *emptyTitle;
@property (nonatomic, copy) NSAttributedString *attributedEmptyTitle;
@property (nonatomic, copy) NSAttributedString *emptyDescription;
@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, strong) UIImage *emptyImageLoading;
@property (nonatomic, strong) UIColor *emptyImageTintColor;
@property (nonatomic, strong) CAAnimation *emptyAnimation;
@property (nonatomic, strong) UIColor *emptyViewBackgroundColor;
@property (nonatomic, copy) NSAttributedString *emptyButtonTitleNormal;
@property (nonatomic, copy) NSAttributedString *emptyButtonTitleHighlighted;
@property (nonatomic, copy) NSAttributedString *emptyButtonTitleSelected;
@property (nonatomic, copy) NSAttributedString *emptyButtonTitleDisabled;
@property (nonatomic, strong) UIImage *emptyButtonImageNormal;
@property (nonatomic, strong) UIImage *emptyButtonImageHighlighted;
@property (nonatomic, strong) UIImage *emptyButtonImageSelected;
@property (nonatomic, strong) UIImage *emptyButtonImageDisabled;
@property (nonatomic, strong) UIImage *emptyButtonBackgroundImageNormal;
@property (nonatomic, strong) UIImage *emptyButtonBackgroundImageHighlighted;
@property (nonatomic, strong) UIImage *emptyButtonBackgroundImageSelected;
@property (nonatomic, strong) UIImage *emptyButtonBackgroundImageDisabled;
@property (nonatomic, strong) UIView *emptyCustomView;
@property (nonatomic, assign) CGPoint emptyContentOffset;
@property (nonatomic, assign) CGFloat emptyVerticalOffset;
@property (nonatomic, assign) CGFloat emptyElementsSpace;

//Empty 方法
@property (nonatomic, copy) ZDBlock_Void emptyViewWillAppearBlock;
@property (nonatomic, copy) ZDBlock_Void emptyViewDidAppearBlock;
@property (nonatomic, copy) ZDBlock_Void emptyViewWillDisappearBlock;
@property (nonatomic, copy) ZDBlock_Void emptyViewDidDisappearBlock;
@property (nonatomic, copy) ZDBlock_Void emptyViewTapedBlock;
@property (nonatomic, copy) ZDBlock_Void emptyButtonTapedBlock;

- (void)viewDidLoad NS_REQUIRES_SUPER;
- (void)viewWillAppear:(BOOL)animated NS_REQUIRES_SUPER;
- (void)viewWillDisappear:(BOOL)animated NS_REQUIRES_SUPER;
@property (nonatomic, assign) BOOL fromPush;

@end
