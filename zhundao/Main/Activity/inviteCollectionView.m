//
//  inviteCollectionView.m
//  zhundao
//
//  Created by zhundao on 2017/8/30.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "inviteCollectionView.h"
#import "InviteCollectionViewCell.h"
static NSString *cellID = @"inviteID";

@interface inviteCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

/*! 分页控制器 */
@property(nonatomic,strong)   UIPageControl    *pageControl;
/*! 显示的数组 */
@property(nonatomic,strong)   NSArray    *imageArray ;
@end

@implementation inviteCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout imageArray :(NSArray *)imageArray View : (UIView *)View{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _imageArray = [imageArray copy];
        self.dataSource =self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = ZDBackgroundColor;
        [self registerClass:[InviteCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [View insertSubview:self.pageControl atIndex:4];
    }
    return self;
}

/*! pageControl初始化 */
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        /*! 设置pageControl的中心点 */
        _pageControl.center = CGPointMake(kScreenWidth*0.5, kScreenHeight-50);
        /*! 设置bounds 这里为设置宽高 */
        _pageControl.bounds = CGRectMake(0, 0, kScreenWidth-200 , 20);
        /*! 设置分页控制器的颜色 */
        _pageControl.pageIndicatorTintColor = kColorA(87, 87, 87, 1);
        /*! 设置分页控制器当前页面选中的颜色 */
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        /*! 分页控制器不能点击 */
        _pageControl.enabled = YES;
        //        [_pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
        /*! 设置分页控制器点的个数 */
        _pageControl.numberOfPages = 3;
        
    }
    return _pageControl;
}

#pragma mark ---UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[InviteCollectionViewCell alloc]init];
    }
    cell.currentImage = _imageArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_inviteDelegate dismissVC];
}

#pragma mark  ----滑动事件

/*! 开始拖动 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
}
/*! 结束拖动 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   
}
/*! 滚动时候调用 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int)(scrollView.contentOffset.x/kScreenWidth+0.5) % 3;
    self.pageControl.currentPage = page;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      [_inviteDelegate selectIndex:self.pageControl.currentPage];
}

- (void)dealloc{
    NSLog(@"没有内存问题1");
}
@end
