#import "PGWithRoundCorner.h"
#import "PGActivityNewPersonVC.h"
#import "PGAvtivityOptions.h"
#import "PGAvtivityCCDatePickerView.h"
#import "Time.h"
#import "PGActivityNewPersonViewModel.h"
#import "PGActivityEditSignListViewModel.h"
#import "PGActivityEditSignListCell.h"
#import "BDImagePicker.h"
#import "PGNewOrEditMV.h"
#import "PGActivityEditMoreChooseVC.h"
#import "PGActivityMoreLabelVC.h"
#define  kLineSpace  ((kScreenWidth-40)/3)
@interface PGActivityNewPersonVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView ;
@property(nonatomic,strong)PGActivityNewPersonViewModel *personVM;
@property(nonatomic,strong)PGActivityEditSignListViewModel *editVM;
@property(nonatomic,copy)NSString *feeStr;
@property(nonatomic,strong)NSMutableArray *baseNameArray; 
@property(nonatomic,strong)NSMutableArray *leftMustArray; 
@property(nonatomic,strong)NSMutableArray *rightMustArray ; 
@property(nonatomic,strong)NSMutableArray *mustTypeArray ; 
@property(nonatomic,strong)NSMutableArray *requireArray ;
@end
@implementation PGActivityNewPersonVC
- (void)viewDidLoad {
dispatch_async(dispatch_get_main_queue(), ^{
    UIEdgeInsets chatInputTextp5 = UIEdgeInsetsZero;
        UIScrollView *frontFromBacko9= [[UIScrollView alloc] initWithFrame:CGRectZero]; 
    frontFromBacko9.showsHorizontalScrollIndicator = NO; 
    frontFromBacko9.showsVerticalScrollIndicator = NO; 
    frontFromBacko9.bounces = NO; 
    frontFromBacko9.maximumZoomScale = 5; 
    frontFromBacko9.minimumZoomScale = 1; 
    PGWithRoundCorner *collectionReusableView= [[PGWithRoundCorner alloc] init];
[collectionReusableView networkReachabilityStatusWithdrivingRouteSearch:chatInputTextp5 listViewModel:frontFromBacko9 ];
});
    [super viewDidLoad];
      [self baseSetting];
}
#pragma mark --- baseSetting 基础设置 
- (void)baseSetting
{
    self.title = @"添加报名人员";
    [self rightButton];
     _editVM = [[PGActivityEditSignListViewModel alloc]init];
    _personVM = [[PGActivityNewPersonViewModel alloc]init];
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
    NSArray *allOptionArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"optionArray%li",(long)self.activityID]];  
    _baseNameArray = [[_personVM getBaseName:self.userInfo] mutableCopy];
    self.leftMustArray = [_editVM getMustArrayFromArray:_baseNameArray customArray:allOptionArray];
    self.rightMustArray = [_personVM getRightArray:self.baseNameArray allOptionArray:allOptionArray];
    if (self.feeArray.count>0) {
        [self.leftMustArray addObject:@"费用选择"];
        [self.rightMustArray addObject:@"未填写*"];
    }
    self.mustTypeArray = [_editVM getMustInputTypeFromArray:self.baseNameArray customArray:allOptionArray];
    self.requireArray = [_editVM getRequiredArray:_baseNameArray allOptionArray:allOptionArray];
    if (self.feeArray.count>0) {
        [self.requireArray addObject:@"1"];
        [self.mustTypeArray addObject:@(5)];
    }
    [_tableView reloadData];
}
#pragma mark 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)style:UITableViewStyleGrouped];
        _tableView.dataSource =self;
        _tableView.delegate =self;
    }
    return  _tableView;
}
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftMustArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PGActivityEditSignListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditCellID"];
    if (!cell) {
        cell = [[PGActivityEditSignListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditCellID"];
    }
    while (cell.contentView.subviews.lastObject!=nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
   cell.tag = (long)indexPath.row;
    [self createViewWithCell:cell];
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([_mustTypeArray[indexPath.row]integerValue]==4) {
            NSMutableArray *array =[[_rightMustArray[indexPath.row] componentsSeparatedByString:@"|"] mutableCopy];
            [array removeObject:@""];
            return  array.count/3*(kLineSpace+10)+ kLineSpace+64  ;
        }
        else  return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
      return [self createHeader];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return  [self createFooter];
}
#pragma mark TextField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    PGActivityEditSignListCell *cell = (PGActivityEditSignListCell *)textField.superview.superview;
    if ([_mustTypeArray[cell.tag] integerValue]==1) {
        [self.view endEditing:YES];
        [self pushToLabelEditWithIsMust:[_requireArray[cell.tag] boolValue] tag:cell.tag];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    PGActivityEditSignListCell *cell = (PGActivityEditSignListCell *)textField.superview.superview;
    if ([_requireArray[cell.tag] boolValue]) {  
        if ([_mustTypeArray[cell.tag] integerValue]==1) {
            return;
        }
       else if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
            [_rightMustArray replaceObjectAtIndex:cell.tag withObject:textField.text];
        }else{
            [self.view endEditing:YES];
            if ([[_rightMustArray objectAtIndex:cell.tag] isEqualToString:@"未填写*"]) {
                textField.text = @"";
            }
            else{
                textField.text = [_rightMustArray objectAtIndex:cell.tag];
            }
            PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"该输入框为必填项"];
            [label labelAnimationWithViewlong:self.view];
            return;
        }
    }
    if(![_requireArray[cell.tag] boolValue]){
        if ([_mustTypeArray[cell.tag] integerValue]==1) {
            return;
        }
        if (textField.text.length>0)   [_rightMustArray replaceObjectAtIndex:cell.tag withObject:textField.text];
        else [_rightMustArray replaceObjectAtIndex:cell.tag withObject:@"未填写"];
    }
    [_tableView reloadData];
}
#pragma mark跳转至文本填写界面
- (void)pushToLabelEditWithIsMust :(BOOL )isMust tag :(NSInteger)tagIndex
{
    PGActivityMoreLabelVC *moreLabel = [[PGActivityMoreLabelVC alloc]init];
    moreLabel.isMust = isMust;
    moreLabel.textfTitle = _rightMustArray[tagIndex];  
    [self.navigationController pushViewController:moreLabel animated:NO];
    moreLabel.strBlock = ^(NSString *str)  
    {
        if (str.length==0) {
            [_rightMustArray replaceObjectAtIndex:tagIndex withObject:@"未填写"];
        }else
        {
            [_rightMustArray replaceObjectAtIndex:tagIndex withObject:str];
        }
        [_tableView reloadData];
    };
}
#pragma mark 头尾视图创建
- (UIView *) createHeader  
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    return view;
}
- (UIView *) createFooter   
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
#pragma mark cell上视图创建
- (void)createViewWithCell :(PGActivityEditSignListCell *)cell
{
        [self createLeftLabelWithStr:_leftMustArray[cell.tag] view:cell.contentView]; 
        if ([_mustTypeArray[cell.tag] integerValue]==2||[_mustTypeArray[cell.tag] integerValue]==3||[_mustTypeArray[cell.tag] integerValue]==5||[_mustTypeArray[cell.tag] integerValue]==6) {
            [self createRightLabelWithStr:_rightMustArray[cell.tag] view:cell.contentView];
        }else if ([_mustTypeArray[cell.tag] integerValue]==0||[_mustTypeArray[cell.tag] integerValue]==1||[_mustTypeArray[cell.tag] integerValue]==7)
        {
            [self createTextFieldWithStr:_rightMustArray[cell.tag] index:[_mustTypeArray[cell.tag] integerValue] view:cell.contentView];
        }else
        {
            [self createImageWithStr:_rightMustArray[cell.tag]  Cell:cell];
        }
}
- (void)createImageWithStr :(NSString *)str Cell :(PGActivityEditSignListCell *)cell
{
    NSMutableArray *imageArray = nil;
    if (str.length>0) {
        imageArray =  [[str componentsSeparatedByString:@"|"] mutableCopy];
        [imageArray removeObject:@""];
        [imageArray removeObject:@"未填写*"];
        [imageArray removeObject:@"未填写"];
    }
    [self createImageViewWithCell1:cell imageArray:imageArray];
}
- (void)createLeftLabelWithStr:(NSString *)Str view :(UIView *)view  
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 44) Text:Str textColor:[UIColor blackColor] font:KweixinFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [view addSubview:label];
}
- (void)createRightLabelWithStr :(NSString *)str  view :(UIView *)view  
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(95, 0, kScreenWidth-120, 44)];
    label.font =KweixinFont(14);
    if ([str isEqualToString:@"未填写*"])  label.attributedText = [_editVM setAttrbriteStrWithText:str];
    else
    {
        label.text =str;
        label.textColor =[UIColor blackColor];
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesAction:)];
    [label addGestureRecognizer:tap];
    [view addSubview:label];
}
- (void)createTextFieldWithStr :(NSString *)str index :(NSInteger)index view :(UIView *)view 
{
    UITextField *textField = [myTextField initWithFrame:CGRectMake(95, 0, kScreenWidth-120, 44) placeholder:str font:KweixinFont(14) TextAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
    textField.delegate =self;
    [_editVM setKeyboardTypeWithtextf:textField type:index];
    if ([str isEqualToString:@"未填写*"]||[str isEqualToString:@"未填写"]) {
        textField.attributedPlaceholder = [_editVM setAttrbriteStrWithText:str];
    }
    else
    {
        textField.text =str;
        textField.attributedPlaceholder = [_editVM setAttrbriteStrWithText:@"未填写*"];
    }
    [view addSubview:textField];
}
#pragma mark label UITapGestureRecognizer 手势点击
- (void)gesAction:(UITapGestureRecognizer *)tap
{
    PGActivityEditSignListCell *cell = (PGActivityEditSignListCell *)tap.view.superview.superview;
    NSArray *allOptionArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"optionArray%li",(long)self.activityID]];  
        switch ([_mustTypeArray[cell.tag] integerValue]) {
            case 2:
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:NO];
                break;
            case 3:
            {
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:YES];
            }
                break;
            case 5:
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:NO];
                break;
            case 6:
                [self showDataPicker:cell];
                break;
            default:
                break;
        }
}
- (void)pushMustChooseWithCell :(PGActivityEditSignListCell *)cell customArray :(NSArray *)customArray isMoreChoose :(BOOL)isMoreChoose
{
    PGActivityEditMoreChooseVC *moreChoose = [[PGActivityEditMoreChooseVC alloc]init];
    if (_feeArray.count>0&&cell.tag==_leftMustArray.count-1) {
        moreChoose.allDataArray = [_personVM getFeeArray:self.feeArray];
        moreChoose.nowDataArray = [_editVM getNowChooseArrayWithStr:_rightMustArray[cell.tag]];
    }else{
        moreChoose.allDataArray = [[_editVM getAllChooseArrayWithStr:_leftMustArray[cell.tag] customArray:customArray] copy];
        moreChoose.nowDataArray = [_editVM getNowChooseArrayWithStr:_rightMustArray[cell.tag]];
    }
    moreChoose.isMoreChoose = isMoreChoose;
    moreChoose.isMust = [_requireArray[cell.tag] boolValue];
    [self.navigationController pushViewController:moreChoose animated:YES];
    moreChoose.strBlock = ^(NSString *str)
    {
        _feeStr = [str copy];
        [_rightMustArray  replaceObjectAtIndex:cell.tag withObject:str];
        [_tableView reloadData];
    };
}
#pragma mark 选择图片
- (void)createImageViewWithCell1 :(PGActivityEditSignListCell *)cell imageArray :(NSArray *)imageArray
{
    NSInteger x = 0 ;
    NSInteger y = 0 ;
    for (int i = 0; i < imageArray.count+1; i ++) {
        x = i / 3;  
        y = i% 3 ;   
        if (i < imageArray.count) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10+y*(kLineSpace+10), 54 + x *(kLineSpace+10), kLineSpace, kLineSpace) ];
            [imageview sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]];
            imageview.tag = i+100;
            imageview.userInteractionEnabled = YES;
            [cell.contentView addSubview:imageview];
            UIButton *deleteButton = [MyButton initWithButtonFrame:CGRectMake(kLineSpace-25, 0, 25, 25) title:nil textcolor:nil Target:self action:@selector(deleteImage:) BackgroundColor:nil cornerRadius:0 masksToBounds:0 ];
            [deleteButton setImage:[UIImage imageNamed:@"img_public_delete_can"] forState:UIControlStateNormal];
            deleteButton.tag = i;
            [imageview addSubview:deleteButton];
        }else
        {
            UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+y*(kLineSpace+10), 54+x*(kLineSpace+10), kLineSpace, kLineSpace)] ;
            UIImageView *imageview = [[UIImageView alloc]initWithFrame: CGRectMake(kLineSpace/4, kLineSpace/4, kLineSpace/2, kLineSpace/2)];
            [addImageView addSubview:imageview];
            addImageView.layer.borderWidth = 0.5;
            addImageView.layer.borderColor = ZDPlaceHolderColor.CGColor;
            imageview.image = [UIImage imageNamed:@"img_public_add_new"];
            [cell.contentView addSubview:addImageView];
            addImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageGes:)];
            [addImageView addGestureRecognizer:tap];
        }
    }
}
-(void) addImageGes :(UITapGestureRecognizer *)tap
{
    PGActivityEditSignListCell *cell = (PGActivityEditSignListCell *)tap.view.superview.superview;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            [PGNewOrEditMV changeToNetImage:image block:^(NSString *str) {
                NSString *OriImageStr = _rightMustArray [cell.tag];
                if (OriImageStr.length==0||[OriImageStr isEqualToString:@"未填写*"]||[OriImageStr isEqualToString:@"未填写"]) {
                    OriImageStr = @"";
                    OriImageStr = [OriImageStr stringByAppendingString:str];
                }else
                {
                    OriImageStr = [[OriImageStr stringByAppendingString:@"|"] stringByAppendingString:str];
                }
                [_rightMustArray replaceObjectAtIndex:cell.tag withObject:OriImageStr];
                [_tableView reloadData];
            }];
        }
    }];
}
#pragma mark 删除图片
- (void)deleteImage :(UIButton *)sender
{
    UIResponder *nextResponder = sender.nextResponder;
    PGActivityEditSignListCell *cell = nil;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[PGActivityEditSignListCell class]]) {
            cell = (PGActivityEditSignListCell *)nextResponder;
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
        NSString *imageStr = [_rightMustArray objectAtIndex:cell.tag];
        NSMutableArray *imageArray = [[imageStr componentsSeparatedByString:@"|"] mutableCopy];
        [imageArray removeObjectAtIndex:sender.tag];
        NSString *lastStr = [imageArray componentsJoinedByString:@"|"];
        [_rightMustArray replaceObjectAtIndex:cell.tag withObject:lastStr];
        [_tableView reloadData];
}
#pragma mark 日期创建
- (void)showDataPicker:(PGActivityEditSignListCell *)cell
{
        NSString *timeStr = _rightMustArray[cell.tag];
        if (timeStr.length<11) {
            timeStr = [timeStr stringByAppendingString:@" 00:00"];
        }else {}
        NSDate *date = [[Time alloc]getDateFromStr:timeStr];
        PGAvtivityCCDatePickerView *DataView = [[PGAvtivityCCDatePickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"日期选择" withDate:date];
        [self.view addSubview:DataView];
        DataView.blcok = ^(NSDate *dateString)
        {
            NSString *datestr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)dateString.year,(long)dateString.month,(long)dateString.day];
            [_rightMustArray replaceObjectAtIndex:cell.tag withObject:datestr];
            [_tableView reloadData];
        };
}
#pragma mark 导航栏保存返回
-(void)rightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    NSDictionary *attributes = @{NSFontAttributeName : KweixinFont(17),
                                 NSForegroundColorAttributeName : ZDMainColor};
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)leftButton
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = leftItem;
}
#pragma mark 保存 返回事件
- (void)save
{
    [self.view endEditing:YES];
   NSDictionary *saveDic =  [_editVM SaveWithRightMustArray:_rightMustArray leftMustArray:_leftMustArray baseArray:self.baseNameArray view:self.view];
    if (saveDic) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:saveDic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""] ;
        NSMutableDictionary *postDIC = [NSMutableDictionary dictionary];
        NSArray *baseRight = [_personVM getBaseRightArray:_rightMustArray count:_baseNameArray.count];
        NSArray *engArray = [_editVM getLastPostArray:_baseNameArray];
        for (int i = 0;  i <_baseNameArray.count; i++) {
            [postDIC setObject:baseRight[i] forKey:engArray[i]];
            if ([_baseNameArray[i] isEqualToString:@"性别"]) {
              NSInteger mySex =   [_editVM getSexSelectStr:baseRight[i]];
              [postDIC setObject:@(mySex) forKey:engArray[i]];
            }
        }
        [postDIC setObject:jsonStr forKey:@"ExtraInfo"];
        [postDIC setObject:@(self.activityID) forKey:@"ActivityID"];
        NSInteger __block lastFeeId = 0;
        [_personVM getFeeidFromArray:_feeArray selectStr:_feeStr feeidBlock:^(NSInteger feeid) {
            lastFeeId = feeid;
        }];
        [_personVM addPersonNetWork:postDIC feeid:lastFeeId];
         __weak typeof(self) weakSelf = self;
        __weak typeof(_fleshBlock) weakBlock =_fleshBlock;
        _personVM.blcok =^(NSInteger isSuccess)
        {
            if (isSuccess==1) {
                MBProgressHUD *hud = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"编辑成功" showAnimated:YES UIView:weakSelf.view imageName:@"img_public_signin_check"];
                [hud hideAnimated:YES afterDelay:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakBlock(1);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (isSuccess==2)
            {
                PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:@"请检查手机格式"];
                [label labelAnimationWithViewlong:weakSelf.view];
            }
            else
            {
                [[PGSignManager shareManager]showNotHaveNet:weakSelf.view];
            }
        };
#pragma mark 网络请求post
    }else{
        return;
    }
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
