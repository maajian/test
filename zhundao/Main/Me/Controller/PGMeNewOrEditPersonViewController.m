#import "PGAssetPropertyDuration.h"
#import "PGMeNewOrEditPersonViewController.h"
#import "PGMePersonMV.h"
#import "UIAlertController+creat.h"
#import "PGNewOrEditMV.h"
#import "PGMeChooseGroupViewController.h"
#import "BDImagePicker.h"
#import "NSString+getColorFromFirst.h"
#import "UIImage+LGExtension.h"
#import "PGMeGroupMV.h"
#import "PGMeContactViewController.h"
@interface PGMeNewOrEditPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableview ;
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,copy)NSArray *nameArray;
@property(nonatomic,copy)NSArray *keyArray; 
@property(nonatomic,strong)NSMutableDictionary *postDic;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)PGNewOrEditMV *mv;   
@property(nonatomic,copy)NSString *imageUrl  ;   
@end
@implementation PGMeNewOrEditPersonViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseSetting];
}
#pragma  mark   baseSetting  基础设置
-(void)baseSetting
{
    _mv = [[PGNewOrEditMV alloc]init];
    [self.view addSubview:self.tableview];
    self.view.backgroundColor = ZDBackgroundColor;
    [self leftButton];
    [self rightButton];
    PGMePersonMV *mv = [[PGMePersonMV alloc]init];
    if (self.personID) {
        self.title = @"编辑联系人";
        _dataArray = [[mv searchDatabaseFromID:self.personID] copy];
        [self getDataarray];
    }
    else{
        self.title = @"新建联系人";
        _dataArray = @[@"未填写*",@"未填写*",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写",@"未填写"];
    }
     [_tableview reloadData];
}
- (void)getDataarray
{
    NSMutableArray *array = [_dataArray mutableCopy];
    for (NSString *str in _dataArray) {
        if ([str isEqualToString:@"(null)"]||[str isEqualToString:@""]) {
            [array replaceObjectAtIndex:[_dataArray indexOfObject:str] withObject:@"未填写"];
             _dataArray = [array copy];
        }
    }
    if ([array[8] isEqualToString:@"0"]) {
        [array replaceObjectAtIndex:8 withObject:@""];
        _dataArray = [array copy];
    }
   _dataArray  = [[_mv sexChangeWithArray:_dataArray muArray:array] copy];
}
#pragma  mark  导航栏返回和完成
- (void)leftButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)leftAction
{
    UIAlertController *alert = [UIAlertController initWithHaveCancelAndSure:nil message:@"是否保存编辑" sureAction:^(UIAlertAction *action) {
        [self savaAction];
    } cancelAction:^(UIAlertAction *action1) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)rightButton   
{
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savaAction)];
    NSDictionary *dic = @{NSFontAttributeName : KHeitiSCMedium(17),
                          NSForegroundColorAttributeName:ZDMainColor};
    [item2 setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item2;
}
#pragma  mark懒加载
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _tableview.backgroundColor = ZDBackgroundColor;
    }
    return _tableview;
}
- (NSMutableDictionary *)postDic
{
    if (!_postDic) {
        _postDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < self.keyArray.count; i++) {
            [_postDic setObject:self.dataArray[i] forKey:_keyArray[i]];
        }
    }
    return _postDic;
}
- (NSArray *)keyArray
{
    if (!_keyArray) {
        _keyArray = @[@"TrueName",@"Mobile",@"HeadImgurl",@"Sex",@"ContactGroupID",@"Address",@"Company",@"Duty",@"IDcard",@"Email",@"SerialNo",@"Remark"];
    }
    return _keyArray;
}
- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"姓名",@"手机",@"头像",@"性别",@"分组",@"地址",@"公司",@"职务",@"身份证",@"邮箱",@"编号",@"备注"];
    }
    return _nameArray;
}
- (UIImageView *)imageview
{
    if (!_imageview) {
        _imageview = [[UIImageView alloc]init];
    }
    return _imageview;
}
#pragma  mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    else{
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewID"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if ((indexPath.row==1&&indexPath.section==1)||(indexPath.row==2&&indexPath.section==1)) {
        [self createLeftLabelWithIndex:indexPath.row+2 view:cell.contentView];
        [self createRightLabelWithIndex:indexPath.row+2 view:cell.contentView];
    }
    else{
        if (indexPath.section==0) {
            [self createTextFieldWithIndex:indexPath.row view:cell.contentView];
            [self createLeftLabelWithIndex:indexPath.row view:cell.contentView];
        }
        else if (indexPath.section==1&&indexPath.row==0)
        {
             UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 60, 80) Text:self.nameArray[indexPath.row+2] textColor:[UIColor blackColor] font:KweixinFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
            [cell.contentView addSubview:label];
            [self createRightImageWithIndex:indexPath.row+2 view:cell.contentView];
            cell.tag=indexPath.row+102;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesAction:)];
            [cell addGestureRecognizer:tap];
            if ([_dataArray[indexPath.row+2] isEqualToString:@"未填写*"]) {
                if ([_dataArray[0] isEqualToString:@"未填写*"]) {
                    _imageview.image = [UIImage imageNamed:@"user"];
                }
                else{
                    [self imagepick:_dataArray[0] imageView:_imageview];
                }
            }
            else{
                [_imageview sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row+2]]];
            }
        }
        else
        {
            [self createLeftLabelWithIndex:indexPath.row+2 view:cell.contentView];
            [self createTextFieldWithIndex:indexPath.row+2 view:cell.contentView];
        }
    }
    return cell;
}
#pragma  mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0) {
        return 80;
    }else{
        return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self createFooter];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.1;
    }
    else{
        return 20;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [self createHeaderWithText:@"必填项*"];
    }else{
        return [self createHeaderWithText:@"选填项"];
    }
}
#pragma  mark UITextFieldDelegate 输入框代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_mv isNoDataTextField:textField];
    if (textField.text.length>0) {
        NSMutableArray *array = [_dataArray mutableCopy];
        [array replaceObjectAtIndex:textField.tag-100 withObject:textField.text];
        _dataArray = [array copy];
    }
}
#pragma  mark 视图创建
- (UIView *) createFooter   
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}
- (UIView *) createHeaderWithText:(NSString *)text   
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 100, 30) Text:text textColor:[UIColor colorWithRed:137.0f/256.0f green:137.0f/256.0f blue:137.0f/256.0f alpha:1] font:KHeitiSCMedium(12) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [view addSubview:label];
    label.attributedText = [_mv setAttrbriteStrWithText:text];
    return view;
}
- (void)createLeftLabelWithIndex :(NSInteger)index view :(UIView *)view  
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 60, 44) Text:self.nameArray[index] textColor:[UIColor blackColor] font:KweixinFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [view addSubview:label];
}
- (void)createRightLabelWithIndex :(NSInteger)index view :(UIView *)view  
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, kScreenWidth-95, 44)];
    label.font =KweixinFont(14);
    label.tag = index+100;
    if ([_dataArray[index] isEqualToString:@"未填写*"]||[_dataArray[index] isEqualToString:@"未填写"]) {
        label.attributedText = [_mv setAttrbriteStrWithText:_dataArray[index]];
    }
   else
   {
       label.text =_dataArray[index];
       label.textColor =[UIColor blackColor];
   }
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentRight;
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesAction:)];
    [label addGestureRecognizer:tap];
    [view addSubview:label];
}
- (void)createTextFieldWithIndex :(NSInteger)index view :(UIView *)view 
{
    UITextField *textField = [myTextField initWithFrame:CGRectMake(70, 0, kScreenWidth-95, 44) placeholder:_dataArray[index] font:KweixinFont(14) TextAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
    textField.tag = index+100;
    textField.delegate =self;
    [_mv setKeyboardTypeWithtextf:textField];
    if ([_dataArray[index] isEqualToString:@"未填写*"]||[_dataArray[index] isEqualToString:@"未填写"]) {
        textField.attributedPlaceholder = [_mv setAttrbriteStrWithText:_dataArray[index]];
    }
    else
    {
        textField.text =_dataArray[index];
        if (index<=2)  textField.attributedPlaceholder = [_mv setAttrbriteStrWithText:@"未填写*"];
        else  textField.attributedPlaceholder = [_mv setAttrbriteStrWithText:@"未填写"];
    }
    [view addSubview:textField];
}
- (void)createRightImageWithIndex :(NSInteger)index view :(UIView *)view  
{
    [view addSubview:self.imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.right.equalTo(view.mas_right).offset(-10);
        make.top.equalTo(view.mas_top).offset(10);
    }];
    _imageview.layer.cornerRadius = 30;
    _imageview.layer.masksToBounds = YES;
}
#pragma  mark 手势响应
- (void)gesAction :(UITapGestureRecognizer *)tap  
{
    switch (tap.view.tag-100) {
        case 2:
            [self showImage];
            break;
        case 3:
            [self showAlertWithAlertControllertitle1];
            break;
        case 4:
        {
            [self psuhToChoose];
        }
        break;
        default:
            break;
    }
}
- (void)psuhToChoose  
{
    PGMeChooseGroupViewController *choose = [[PGMeChooseGroupViewController alloc]init];
    choose.nameStr = _dataArray[4];
    choose.personid = self.personID;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:choose animated:YES];
    choose.block = ^(NSString *groupName,NSInteger groupID)
    {
        NSMutableArray *Array = [_dataArray mutableCopy];
        [Array replaceObjectAtIndex:4 withObject:groupName];
        _dataArray = [Array copy];
        [_postDic setObject:[NSString stringWithFormat:@"%li",(long)groupID]  forKey:@"ContactGroupID"];
        [_tableview reloadData];
    };
}
- (void)showImage 
{
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        _imageview.image = image;
        [PGNewOrEditMV changeToNetImage:image block:^(NSString *str) {
            _imageUrl = [str copy];
        }];
    }];
}
- (void)showAlertWithAlertControllertitle1 
{
    ZD_WeakSelf
    [PGAlertSheet showWithArray:@[@"未知", @"男", @"女"] title:@"性别" isDelete:NO selectBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf changeDataWithIndex:0 Str:@"未知"];
        } else if (index == 1) {
            [weakSelf changeDataWithIndex:1 Str:@"男"];
        } else {
            [weakSelf changeDataWithIndex:2 Str:@"女"];
        }
    }];
}
- (void)changeDataWithIndex :(NSInteger )index Str :(NSString *)str  
{
     NSMutableArray *Array = [_dataArray mutableCopy];
    [Array replaceObjectAtIndex:3 withObject:str];
    _dataArray = [Array copy];
    [_tableview reloadData];
}
- (void)imagepick:(NSString *)str imageView :(UIImageView *)imageView  
{
    NSString *text =str;
    UIColor *color = [[NSString alloc]getColorWithStr:str];
    if (text.length<=2) {
        text = str;
    }
    else
    {
        text = [text substringWithRange:NSMakeRange(text.length-2, 2)];
    }
    imageView.image = [UIImage circleImageWithText:text bgColor:color size:CGSizeMake(60,60)];
}
#pragma  mark 保存操作 
- (void)savaAction
{
    [self.view endEditing:YES];
    _postDic = nil;
    NSMutableDictionary *dic = [self.postDic mutableCopy];
    for (int i = 0; i <_dataArray.count; i++) {
        if ([_dataArray[i] isEqualToString:@"未填写*"]||[_dataArray[i] isEqualToString:@"未填写"]) {
            [dic removeObjectForKey:_keyArray[i]];
        }
    }
    if ([_dataArray[0] isEqualToString:@"未填写*"]) {
        [self showMaskLabel:@"请填写姓名"];
        return;
    }
    if ([_dataArray[1] isEqualToString:@"未填写*"] ) {
        [self showMaskLabel:@"请填写手机"];
        return;
    }
    if (_imageUrl) {
        [self.postDic setObject:_imageUrl forKey:@"HeadImgurl"];
    }
    if (_personID) {
        [dic setObject:[NSString stringWithFormat:@"%li",(long)_personID] forKey:@"ID"];
    }
    [dic setObject:[_mv sexChangeToStr:_dataArray[3]] forKey:@"Sex"];
    if (_personID) {
    [dic setObject:[_mv searchContactGroupIDFromID:_personID]  forKey:@"ContactGroupID"] ;
    }
    [self postDataWithDic:dic];
}
- (void)postDataWithDic :(NSDictionary *)dic
{
    PGMeGroupMV *mv = [[PGMeGroupMV alloc]init];
    [mv addPersonToGroupWithDic:dic];
    mv.addPersonBlock = ^(BOOL isSuccess)
    {
        if (isSuccess) {
            MBProgressHUD *hud = [PGMyHud initWithMode:MBProgressHUDModeCustomView labelText:@"编辑成功" showAnimated:YES UIView:self.view imageName:@"img_public_signin_check"];
            [hud hideAnimated:YES afterDelay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PGMeContactViewController *contact = nil;
                for (UIViewController *VC in self.navigationController.viewControllers) {
                    if ([VC isKindOfClass:[PGMeContactViewController class]]) {
                        contact = (PGMeContactViewController *)VC;
                    }
                }
                [self.navigationController popToViewController:contact animated:YES];
                [contact netWork];
            });
        }else
        {
            [[PGSignManager shareManager]showNotHaveNet:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
}
- (void)showMaskLabel:(NSString *)str 
{
    PGMaskLabel *label = [[PGMaskLabel alloc]initWithTitle:str];
    [label labelAnimationWithViewlong:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    NSLog(@"修改没有内存泄漏了");
}
@end
