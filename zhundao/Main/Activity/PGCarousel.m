#import "PGNaviTitleColor.h"
//
//  PGCarousel.m
//  AJ轮播图
//
//  Created by zhundao on 2017/8/21.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "PGCarousel.h"
#import "PGCarouselCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

static NSString *cellID = @"cellID";

@interface PGCarousel()<UICollectionViewDelegate,UICollectionViewDataSource>
/*! 分页控制器 */
@property(nonatomic,strong)   UIPageControl    *pageControl;
/*! 显示的数组 */
@property(nonatomic,strong)   NSArray    *imageArray ;
/*! 定时器 */
@property(nonatomic,strong)  NSTimer *timer ;
/*! 保存图片切换时间 */
@property(nonatomic,assign) NSTimeInterval timeInterval;
/*! 是否自动轮播 */
@property(nonatomic,assign) BOOL isScroll;
/*! 图片有多少组 */
@property(nonatomic,assign)NSInteger sectionCount;
@end


@implementation PGCarousel

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:  (UICollectionViewLayout *)layout
                   imageArray:(NSArray *)imageArray
                        View : (UIView *)View{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        /*! 设置代理 */
        self.dataSource =self;
        self.delegate =self;
        /*! 默认图片滑动时间为2 */
        _timeInterval = 2.0  ;
        /*! 初始化默认轮播 */
        _isScroll = YES;
        _sectionCount = 10000;
        self.imageArray = imageArray;
        /*! 不显示滑动条 */
        self.showsHorizontalScrollIndicator = NO;
        /*! 做分页处理，很重要 */
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        /*! 滑动到指定位置 */
        [self registerClass:[PGCarouselCell class] forCellWithReuseIdentifier:cellID];
        [self addTimer];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_sectionCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [View insertSubview:self.pageControl atIndex:4];
    }
    return self;
}


#pragma mark -----懒加载


/*! pageControl初始化 */
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        /*! 设置pageControl的中心点 */
        _pageControl.center = CGPointMake(SCREEN_WIDTH*0.5, 160);
        /*! 设置bounds 这里为设置宽高 */
        _pageControl.bounds = CGRectMake(0, 0, self.frame.size.height - 50 , 40);
        /*! 设置分页控制器的颜色 */
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        /*! 设置分页控制器当前页面选中的颜色 */
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        /*! 分页控制器不能点击 */
        _pageControl.enabled = YES;
//        [_pageControl addTarget:self action:@selector(clickPageControl:) forControlEvents:UIControlEventValueChanged];
        /*! 设置分页控制器点的个数 */
        _pageControl.numberOfPages = _imageArray.count;
        
        
    }
    return _pageControl;
}

#pragma mark ---UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PGCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[PGCarouselCell alloc]init];
    }
    NSLog(@"item = %li",indexPath.item);
    cell.currentImage = _imageArray[indexPath.row];
    /*! 实际使用过程中可以把label移除 ， 避免cell上存在多余的子视图 */
    cell.currentLabelStr = [NSString stringWithFormat:@"这是第%li张图片",(long)indexPath.item + 1];
    
    return cell;
}

#pragma mark --- pageControl点击

//- (void)clickPageControl:(UIPageControl *)pageControl{
//    NSInteger page = pageControl.currentPage;
//    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:1] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
////    self.pageControl.currentPage = page;
//}



#pragma mark 定时器

- (void)addTimer {
    if (_isScroll) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(pageChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }else{
        _sectionCount = 1 ;
        [self reloadData];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_sectionCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (void)removeTimer {
    if (_timer) {
        [self.timer invalidate];
        _timer = nil;
    }
}

- (void)pageChange {
    /*! 计算当前位置 */
    NSIndexPath *indexpath = [self indexPathsForVisibleItems].lastObject;
    NSIndexPath *currentIndexpath = [NSIndexPath indexPathForItem:indexpath.item inSection:indexpath.section];
    [self scrollToItemAtIndexPath:currentIndexpath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexpath.item + 1 ;
    NSInteger nextSection =currentIndexpath.section;
    /*! 如果为最后一个图片 */
    if (nextItem==self.imageArray.count) {
        nextItem=0;
        nextSection++;
    }
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}


#pragma mark  ----滑动事件

/*! 开始拖动 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
         [self removeTimer];
}
/*! 结束拖动 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
dispatch_async(dispatch_get_main_queue(), ^{
    UIScrollView *availableTextureIndexi0= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    availableTextureIndexi0.showsHorizontalScrollIndicator = NO; 
    availableTextureIndexi0.showsVerticalScrollIndicator = NO; 
    availableTextureIndexi0.bounces = NO; 
    availableTextureIndexi0.maximumZoomScale = 5; 
    availableTextureIndexi0.minimumZoomScale = 1; 
        UIEdgeInsets exerciseRecordViewL1 = UIEdgeInsetsMake(207,142,109,75); 
    PGNaviTitleColor *failProvisionalNavigation= [[PGNaviTitleColor alloc] init];
[failProvisionalNavigation pg_asynchronouslyWithCompletionWithwithCourseParticular:availableTextureIndexi0 coachDetailModel:exerciseRecordViewL1 ];
});
    if (_isScroll) {
         [self addTimer];
    }
}
/*! 滚动时候调用 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = (int)(scrollView.contentOffset.x/SCREEN_WIDTH+0.5) % self.imageArray.count;
    self.pageControl.currentPage = page;
    
}



#pragma mark    存取器重写

- (void)setPageTintColor:(UIColor *)pageTintColor{
    _pageControl.pageIndicatorTintColor = pageTintColor;
}
- (UIColor *)pageTintColor{
    return _pageControl.pageIndicatorTintColor;
}

- (void)setCurrentPageColor:(UIColor *)currentPageColor{
dispatch_async(dispatch_get_main_queue(), ^{
    UIScrollView *groupWithPhotosX0= [[UIScrollView alloc] initWithFrame:CGRectMake(53,9,170,80)]; 
    groupWithPhotosX0.showsHorizontalScrollIndicator = NO; 
    groupWithPhotosX0.showsVerticalScrollIndicator = NO; 
    groupWithPhotosX0.bounces = NO; 
    groupWithPhotosX0.maximumZoomScale = 5; 
    groupWithPhotosX0.minimumZoomScale = 1; 
        UIEdgeInsets yearTimeIntervalL4 = UIEdgeInsetsMake(122,22,189,25); 
    PGNaviTitleColor *stadiumViewModel= [[PGNaviTitleColor alloc] init];
[stadiumViewModel pg_asynchronouslyWithCompletionWithwithCourseParticular:groupWithPhotosX0 coachDetailModel:yearTimeIntervalL4 ];
});
    _pageControl.currentPageIndicatorTintColor = currentPageColor;
}

- (UIColor *)currentPageColor{
    return _pageControl.currentPageIndicatorTintColor;
}
- (void)setHiddenPageCtr:(BOOL)hiddenPageCtr{
dispatch_async(dispatch_get_main_queue(), ^{
    UIScrollView *columnistCategoryModeli1= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    columnistCategoryModeli1.showsHorizontalScrollIndicator = NO; 
    columnistCategoryModeli1.showsVerticalScrollIndicator = NO; 
    columnistCategoryModeli1.bounces = NO; 
    columnistCategoryModeli1.maximumZoomScale = 5; 
    columnistCategoryModeli1.minimumZoomScale = 1; 
        UIEdgeInsets rightBottomPointd6 = UIEdgeInsetsMake(134,248,104,72); 
    PGNaviTitleColor *orderStepView= [[PGNaviTitleColor alloc] init];
[orderStepView pg_asynchronouslyWithCompletionWithwithCourseParticular:columnistCategoryModeli1 coachDetailModel:rightBottomPointd6 ];
});
    _pageControl.hidden = hiddenPageCtr;
}

- (void)setDuration:(NSTimeInterval)duration{
    [self removeTimer];
    _timeInterval = duration;
    [self addTimer];
}
- (NSTimeInterval)duration{
    return _timeInterval;
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isScroll = isAutoScroll;
    [self removeTimer];
    [self addTimer];
}
- (BOOL)isAutoScroll{
    return _isScroll;
}
- (void)dealloc{
    NSLog(@"轮播图没有内存泄露");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
