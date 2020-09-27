#import "PGOrganizeListRequset.h"
#import "PGActivityImageBrowserVC.h"
#import "PGActivityPhotoView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface PGActivityImageBrowserVC ()<UIScrollViewDelegate,PhotoViewDelegate,UIActionSheetDelegate>{
    NSMutableArray *_subViewArray;
}
@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,weak) UIViewController *handleVC;
@property (nonatomic,assign) PhotoBroswerVCType type;
@property (nonatomic,strong) NSArray *imagesArray;
@property (nonatomic,assign) NSUInteger index;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) PGActivityPhotoView *photoView;
@end
@implementation PGActivityImageBrowserVC
-(instancetype)init{
    self=[super init];
    if (self) {
        _subViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
- (void)savephotobutton
{
     [UIButton initCreateButtonWithFrame:CGRectMake(0, 0, 25, 25) WithImageName:@"nav_more" Withtarget:self Selector:@selector(savealert)];
}
- (void)addges
{
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savealertaddGestureRecognizer:)];
    tap.minimumPressDuration = 0.5;
    _photoView.userInteractionEnabled = YES;
    [_photoView.imageView addGestureRecognizer:tap];
}
- (void)savealertaddGestureRecognizer :(UILongPressGestureRecognizer *)ges
{
    if ( ges.state ==UIGestureRecognizerStateBegan ) {
        [self savealert];
    }
    else if (ges.state == UIGestureRecognizerStateEnded){
        return;
    }
}
- (void)savealert
{
    UIActionSheet *sheet= [[UIActionSheet alloc] initWithTitle:nil
                                        delegate:self
                               cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                               otherButtonTitles:@"保存图片", nil];
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"保存图片"]) {
        [self saveImageWithFrame];
    }
}
- (void)saveImageWithFrame   
{
    UIImageWriteToSavedPhotosAlbum(_photoView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    PGMaskLabel *label ;
    if (error) {
        label = [[PGMaskLabel alloc]initWithTitle:@"请先打开相机权限"];
    } else {
        label = [[PGMaskLabel alloc]initWithTitle:@"已保存到系统相册"];
    }
    [label labelAnimationWithViewlong:self.view];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self savephotobutton];
    self.view.backgroundColor=[UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.contentSize = CGSizeMake(WIDTH * self.imagesArray.count, 0);
    for (int i = 0; i < self.imagesArray.count; i++) {
        [_subViewArray addObject:[NSNull class]];
    }
    self.scrollView.contentOffset = CGPointMake(WIDTH*self.index, 0);
    if (self.imagesArray.count==1) {
        _pageControl.hidden=YES;
    }else{
        self.pageControl.currentPage=self.index;
    }
    [self PG_loadPhote:self.index];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PG_hideCurrentVC:)];
    [self.view addGestureRecognizer:tap];
       [self addges];
}
-(void)PG_hideCurrentVC:(UIGestureRecognizer *)tap{
    [self PG_hideScanImageVC];
}
#pragma mark - 显示图片
-(void)PG_loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imagesArray.count) {
        return;
    }
    id currentPhotoView = [_subViewArray objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[PGActivityPhotoView class]]) {
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        if ([[self.imagesArray firstObject] isKindOfClass:[UIImage class]]) {
            PGActivityPhotoView *photoV = [[PGActivityPhotoView alloc] initWithFrame:frame withPhotoImage:[self.imagesArray objectAtIndex:index]];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }else if ([[self.imagesArray firstObject] isKindOfClass:[NSString class]]){
            PGActivityPhotoView *photoV = [[PGActivityPhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imagesArray objectAtIndex:index]];
            photoV.delegate = self;
            [self.scrollView insertSubview:photoV atIndex:0];
            [_subViewArray replaceObjectAtIndex:index withObject:photoV];
            self.photoView=photoV;
        }
    }
}
#pragma mark - 生成显示窗口
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock{
    NSArray *photoModels = imagesBlock();
    if(photoModels == nil || photoModels.count == 0) {
        return;
    }
    PGActivityImageBrowserVC *imgBrowserVC = [[self alloc] init];
    if(index >= photoModels.count){
        return;
    }
    imgBrowserVC.index = index;
    imgBrowserVC.imagesArray = photoModels;
    imgBrowserVC.type =type;
    imgBrowserVC.handleVC = handleVC;
    [imgBrowserVC show]; 
}
-(void)show{
    switch (_type) {
        case PhotoBroswerVCTypePush://push
            [self PG_pushPhotoVC];
            self.title = @"图片";
            break;
        case PhotoBroswerVCTypeModal://modal
            [self PG_modalPhotoVC];
            break;
        case PhotoBroswerVCTypeZoom://zoom
            [self PG_zoomPhotoVC];
            break;
        default:
            break;
    }
}
-(void)PG_pushPhotoVC{
    [_handleVC.navigationController pushViewController:self animated:YES];
}
-(void)PG_modalPhotoVC{
    [_handleVC presentViewController:self animated:YES completion:nil];
}
-(void)PG_zoomPhotoVC{
    UIWindow *window = _handleVC.view.window;
    if(window == nil){
        NSLog(@"错误：窗口为空！");
        return;
    }
    self.view.frame=[UIScreen mainScreen].bounds;
    [window addSubview:self.view]; 
    [_handleVC addChildViewController:self]; 
}
#pragma mark - 隐藏当前显示窗口
-(void)PG_hideScanImageVC{
    switch (_type) {
        case PhotoBroswerVCTypePush://push
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case PhotoBroswerVCTypeModal://modal
            [self dismissViewControllerAnimated:YES completion:NULL];
            break;
        case PhotoBroswerVCTypeZoom://zoom
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            break;
        default:
            break;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page<0||page>=self.imagesArray.count) {
        return;
    }
    self.pageControl.currentPage = page;
    for (UIView *view in scrollView.subviews) {
        if ([view isKindOfClass:[PGActivityPhotoView class]]) {
            PGActivityPhotoView *photoV=(PGActivityPhotoView *)[_subViewArray objectAtIndex:page];
            if (photoV!=self.photoView) {
                [self.photoView.scrollView setZoomScale:1.0 animated:YES];
                self.photoView=photoV;
            }
        }
    }
    [self PG_loadPhote:page];
}
#pragma mark - PhotoViewDelegate
-(void)tapHiddenPhotoView{
    [self PG_hideScanImageVC];
}
#pragma mark - 懒加载
-(UIScrollView *)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentOffset=CGPointZero;
        _scrollView.maximumZoomScale=3;
        _scrollView.minimumZoomScale=1;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 30)];
        bottomView.backgroundColor=[UIColor clearColor];
        _pageControl = [[UIPageControl alloc] initWithFrame:bottomView.bounds];
        _pageControl.currentPage = self.index;
        _pageControl.numberOfPages = self.imagesArray.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:153 green:153 blue:153 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:0.6];
        [bottomView addSubview:_pageControl];
        [self.view addSubview:bottomView];
    }
    return _pageControl;
}
#pragma mark - 系统自带代码
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
