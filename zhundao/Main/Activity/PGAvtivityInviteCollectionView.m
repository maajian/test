#import "PGCaseInsensitiveSearch.h"
#import "PGAvtivityInviteCollectionView.h"
#import "PGAvtivityInviteCollectionViewCell.h"
static NSString *cellID = @"inviteID";
@interface PGAvtivityInviteCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)   UIPageControl    *pageControl;
@property(nonatomic,strong)   NSArray    *imageArray ;
@end
@implementation PGAvtivityInviteCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout imageArray :(NSArray *)imageArray View : (UIView *)View{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        _imageArray = [imageArray copy];
        self.dataSource =self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.backgroundColor = ZDBackgroundColor;
        [self registerClass:[PGAvtivityInviteCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        [View insertSubview:self.pageControl atIndex:4];
    }
    return self;
}
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.center = CGPointMake(kScreenWidth*0.5, kScreenHeight-50);
        _pageControl.bounds = CGRectMake(0, 0, kScreenWidth-200 , 20);
        _pageControl.pageIndicatorTintColor = kColorA(87, 87, 87, 1);
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.enabled = YES;
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
    PGAvtivityInviteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[PGAvtivityInviteCollectionViewCell alloc]init];
    }
    cell.currentImage = _imageArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_inviteDelegate dismissVC];
}
#pragma mark  ----滑动事件
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}
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
