#import "PGNaviTitleColor.h"
#import "PGCarousel.h"
#import "PGCarouselCell.h"
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
static NSString *cellID = @"cellID";
@interface PGCarousel()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)   UIPageControl    *pageControl;
@property(nonatomic,strong)   NSArray    *imageArray ;
@property(nonatomic,strong)  NSTimer *timer ;
@property(nonatomic,assign) NSTimeInterval timeInterval;
@property(nonatomic,assign) BOOL isScroll;
@property(nonatomic,assign)NSInteger sectionCount;
@end
@implementation PGCarousel
- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:  (UICollectionViewLayout *)layout
                   imageArray:(NSArray *)imageArray
                        View : (UIView *)View{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dataSource =self;
        self.delegate =self;
        _timeInterval = 2.0  ;
        _isScroll = YES;
        _sectionCount = 10000;
        self.imageArray = imageArray;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[PGCarouselCell class] forCellWithReuseIdentifier:cellID];
        [self addTimer];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_sectionCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [View insertSubview:self.pageControl atIndex:4];
    }
    return self;
}
#pragma mark -----懒加载
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.center = CGPointMake(SCREEN_WIDTH*0.5, 160);
        _pageControl.bounds = CGRectMake(0, 0, self.frame.size.height - 50 , 40);
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.enabled = YES;
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
    cell.currentLabelStr = [NSString stringWithFormat:@"这是第%li张图片",(long)indexPath.item + 1];
    return cell;
}
#pragma mark --- pageControl点击
#pragma mark 定时器
- (void)addTimer {
    if (_isScroll) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(PG_pageChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }else{
        _sectionCount = 1 ;
        [self reloadData];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_sectionCount/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}
- (void)PG_removeTimer {
    if (_timer) {
        [self.timer invalidate];
        _timer = nil;
    }
}
- (void)PG_pageChange {
    NSIndexPath *indexpath = [self indexPathsForVisibleItems].lastObject;
    NSIndexPath *currentIndexpath = [NSIndexPath indexPathForItem:indexpath.item inSection:indexpath.section];
    [self scrollToItemAtIndexPath:currentIndexpath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    NSInteger nextItem = currentIndexpath.item + 1 ;
    NSInteger nextSection =currentIndexpath.section;
    if (nextItem==self.imageArray.count) {
        nextItem=0;
        nextSection++;
    }
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:nextItem inSection:nextSection] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
#pragma mark  ----滑动事件
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
         [self PG_removeTimer];
}
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
[failProvisionalNavigation asynchronouslyWithCompletionWithwithCourseParticular:availableTextureIndexi0 coachDetailModel:exerciseRecordViewL1 ];
});
    if (_isScroll) {
         [self addTimer];
    }
}
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
[stadiumViewModel asynchronouslyWithCompletionWithwithCourseParticular:groupWithPhotosX0 coachDetailModel:yearTimeIntervalL4 ];
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
[orderStepView asynchronouslyWithCompletionWithwithCourseParticular:columnistCategoryModeli1 coachDetailModel:rightBottomPointd6 ];
});
    _pageControl.hidden = hiddenPageCtr;
}
- (void)setDuration:(NSTimeInterval)duration{
    [self PG_removeTimer];
    _timeInterval = duration;
    [self addTimer];
}
- (NSTimeInterval)duration{
    return _timeInterval;
}
- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isScroll = isAutoScroll;
    [self PG_removeTimer];
    [self addTimer];
}
- (BOOL)isAutoScroll{
    return _isScroll;
}
- (void)dealloc{
    NSLog(@"轮播图没有内存泄露");
}
@end
