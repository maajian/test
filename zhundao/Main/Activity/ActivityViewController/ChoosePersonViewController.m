//
//  ChoosePersonViewController.m
//  zhundao
//
//  Created by zhundao on 2017/11/2.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChoosePersonViewController.h"
#import "isReadView.h"
#import "ListTableViewCell.h"
#import "GroupSendViewController.h"
#import "GroupSendViewModel.h"
#import "JQIndicatorView.h"
#import "listModel.h"
//#import "listModel.h"
@interface ChoosePersonViewController ()<UITableViewDataSource,UITableViewDelegate,readDelegate>

@property(nonatomic,strong)UITableView *tableView;
/*! 全选图片 */
@property(nonatomic,strong)UIImageView *imageView;
/*! 全选右边label2 */
@property(nonatomic,strong)UILabel *selectLabel2;
/*! 是否全选 */
@property(nonatomic,assign)NSInteger isSelectAll;
/*! 下面的视图 */
@property(nonatomic,strong)isReadView *readView;
/*! 无效人数 */
@property(nonatomic,assign)NSInteger InvalidCount;
///*! 有效数据 */
@property(nonatomic,strong)NSMutableArray *validArray;

@end

@implementation ChoosePersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _InvalidCount = 0;
    self.title = @"群发管理";
    _validArray = [NSMutableArray array];
    _isSelectAll = NO;
    [self setupUI];
    [self selectALL];
    [self OpenMessage];
    // Do any additional setup after loading the view.
}

#pragma mark --- 网络请求
/*! 开通短信 */
- (void)OpenMessage{
    GroupSendViewModel *viewModel = [[GroupSendViewModel alloc]init];
    [viewModel openMessage:^(id responseObject) {
    } error:^(NSError *error) {
    }];
    
    
}
#pragma mark 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-44)];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.backgroundColor = ZDBackgroundColor;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight = 75 ;
        _tableView.tintColor = [UIColor clearColor];
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setEditing:YES animated:YES];
        _tableView.tableHeaderView = [self createHeaderView];
        [_tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listcell"];
    }
    return _tableView;
}

#pragma mark --- ui创建
- (void)setupUI{
    _readView = [[isReadView alloc]init];
    _readView.readDelegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:_readView];
    [self.readView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(ZD_SAFE_BOTTOM_LAYOUT);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.bottom.equalTo(self.readView.mas_top);
    }];
}

#pragma mark -------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listcell"];
    if (cell==nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listcell"];
    }
    cell.model = _modelArray[indexPath.row];
    cell.lineView.hidden = YES;
    cell.listCount.text =[NSString stringWithFormat:@"%li",(long)cell.model.count];
    return cell;
}
#pragma mark -------UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    listModel *model = _modelArray[indexPath.row];
    if (model.Mobile.length!=11){
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"非中国大陆手机号将被自动排除"];
        [label labelAnimationWithViewlong:self.view];
        return;
    }
    NSArray *array = [tableView indexPathsForSelectedRows];
    if (array.count == _modelArray.count-_InvalidCount) {
        _isSelectAll = YES;
    }
    [self showInfo:array];
    [self showNextStepButton:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
      NSArray *array = [tableView indexPathsForSelectedRows];
      _isSelectAll = NO;
    [self showInfo:array];
    if (array.count==0) {
        [self showNextStepButton:NO];
    }
}


#pragma mark --- 创建头视图
- (UIView *)createHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 55)];
    view.backgroundColor = [UIColor clearColor];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 18.5, 18, 18)];
    _imageView.image = [UIImage imageNamed:@"option打勾"];
    _imageView.layer.borderColor = ZDGrayColor.CGColor;
    _imageView.layer.borderWidth = 0.5;
    _imageView.layer.cornerRadius = 9;
    _imageView.layer.masksToBounds = YES;
    [view addSubview:_imageView];
    UILabel  *_selectLabel1 = [[UILabel alloc]init];
    _selectLabel1.font = [UIFont systemFontOfSize:13];
    _selectLabel1.text = @"全选";
    [view addSubview:_selectLabel1];
    [_selectLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
        make.left.equalTo(_imageView.mas_right).offset(4);
        make.width.mas_offset(30);
    }];
    _selectLabel2 = [[UILabel alloc]init];
    _selectLabel2.font = [UIFont systemFontOfSize:12];
    _selectLabel2.textColor = kColorA(100, 100, 100, 1);
    _selectLabel2.text = [NSString stringWithFormat:@"请选择收件人(已选择%li人)",_modelArray.count];
    [view addSubview:_selectLabel2];
    [_selectLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectLabel1.mas_right).offset(2);
        make.width.mas_offset(kScreenWidth-100);
        make.top.equalTo(view).offset(0);
        make.bottom.equalTo(view).offset(0);
    }];
    [view layoutIfNeeded];
    /*! 添加全选手势 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectALL)];
    [view addGestureRecognizer:tap];
    return view;
    
}

#pragma mark --- readDelegate

- (void)cancelSend{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextStep{
    NSArray *lastSelectArray = [_tableView indexPathsForSelectedRows];
    GroupSendViewController *group = [[GroupSendViewController alloc]init];
    [self setHidesBottomBarWhenPushed:YES];
    group.modelArray = _modelArray;
    group.selectArray = lastSelectArray;
    group.activityName = _activityName;
    group.activityID = _activityID;
    [self.navigationController pushViewController:group animated:YES];
}

#pragma mark --- 全选功能

- (void)selectALL {
    _InvalidCount = 0;
    _isSelectAll = !_isSelectAll;
    if (_isSelectAll) {
        [_validArray removeAllObjects];
        for (int i = 0; i<_modelArray.count; i++) {
            @autoreleasepool{
                listModel *model = _modelArray[i];
                if (model.Mobile.length!=11) {
                    _InvalidCount +=1;
                    continue;
                }else{
                    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                    [_validArray addObject:_modelArray[i]];
                }
            }
        }
        [self showNextStepButton:YES];
        [self showInfo:_validArray];
    }else{
        for (int i = 0; i<_modelArray.count; i++) {
            @autoreleasepool{
                listModel *model = _modelArray[i];
                if (model.Mobile.length!=11) {
                    continue;
                }else{
                    [_tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
                }
            }
        }
        _imageView.image = [UIImage imageNamed:@""];
        _selectLabel2.text = @"请选择收件人(已选择0人)";
        [self showNextStepButton:NO];
        [_readView.nextStepButton setTitle:@"下一步(已选0人)" forState:UIControlStateNormal];
    }
}

- (void)showInfo :(NSArray *)infoArray{
    if (_isSelectAll) {
        _imageView.image = [UIImage imageNamed:@"option打勾"];
    }else{
        _imageView.image = [UIImage imageNamed:@""];
    }
    _selectLabel2.text = [NSString stringWithFormat:@"请选择收件人(已选择%li人)",infoArray.count];
    [_readView.nextStepButton setTitle:[NSString stringWithFormat:@"下一步(已选%li人)",infoArray.count] forState:UIControlStateNormal];
}

- (void)showNextStepButton:(BOOL)number{
    if (number) {
        _readView.nextStepButton.userInteractionEnabled = YES;
        [_readView.nextStepButton setTitleColor:kColorA(11, 120, 205, 1) forState:UIControlStateNormal];
    }else{
        _readView.nextStepButton.userInteractionEnabled = NO;
        [_readView.nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)dealloc{
    NSLog(@"%@", [NSString stringWithFormat:@"%@dealloc",self.title]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
