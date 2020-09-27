#import "PGVideoWithScroll.h"
#import "PGActivityBigImageCollectionView.h"
#import "PGActivityBigImageCell.h"
#import "PGActivityChooseBigImageViewModel.h"
static NSString *cellID = @"BigImageCollectionCellID";
static NSString *headerID = @"BigImageCollectionCellHeaderID";
@interface PGActivityBigImageCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,assign,readwrite)NSInteger selectIndex;
@property(nonatomic,strong,readwrite)UIImageView *selectImageView;
@property(nonatomic,strong)NSMutableArray *heightArray;
@property(nonatomic,strong)PGActivityChooseBigImageViewModel *viewModel;
@end
@implementation PGActivityBigImageCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.scrollEnabled = NO;
        [self registerClass:[PGActivityBigImageCell class] forCellWithReuseIdentifier:cellID];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    }
    return self;
}
#pragma mark --- 懒加载
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [MyLabel initWithLabelFrame:CGRectMake(20, 0, 100, 40) Text:_headerTitle textColor:ZDHeaderTitleColor font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    }
    return _nameLabel;
}
- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        _selectImageView.image = [UIImage imageNamed:@"option打勾"];
    }
    return _selectImageView;
}
#pragma mark --- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PGActivityBigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *imageDic = _dataArray[indexPath.item];
    cell.imageStr = imageDic[@"Link"];
    if ((self.tag == _currentTag) && (indexPath.item == _currentItem)) {
        [cell.bigImageView addSubview:self.selectImageView];
        _selectImageView.tag = 1000;
    }
    return cell;
}
#pragma  mark --- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PGActivityBigImageCell *Cell = (PGActivityBigImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIResponder *responder = Cell.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *)responder;
            UIImageView *imageView = [tableView viewWithTag:1000];
            if (imageView) {
                [imageView removeFromSuperview];
            }
            break;
        }
        responder = responder.nextResponder;
    }
    [Cell.bigImageView addSubview:self.selectImageView];
    _selectImageView.tag = 1000;
    if ([self.imageSelectDelegate respondsToSelector:@selector(selectIndex:item:tag:)]) {
        NSDictionary *imageDic = _dataArray[indexPath.item];
        [self.imageSelectDelegate selectIndex:imageDic[@"Link"] item:indexPath.item tag:self.tag];
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
    if (kind == UICollectionElementKindSectionHeader) {
        [header addSubview:self.nameLabel];
        return header;
    }
    return nil;
}
@end
