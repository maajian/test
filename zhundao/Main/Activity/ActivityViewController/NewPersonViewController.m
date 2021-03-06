//
//  NewPersonViewController.m
//  zhundao
//
//  Created by zhundao on 2017/7/10.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "NewPersonViewController.h"

#import "AvtivityOptions.h"
#import "CCDatePickerView.h"
#import "Time.h"
#import "NewPersonViewModel.h"
#import "EditSignListViewModel.h"
#import "EditSignListTableViewCell.h"
#import "BDImagePicker.h"
#import "NewOrEditMV.h"
#import "EditMoreChooseViewController.h"
#import "MoreLabelViewController.h"
#define  kLineSpace  ((kScreenWidth-40)/3)
@interface NewPersonViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableView ;
@property(nonatomic,strong)NewPersonViewModel *personVM;
@property(nonatomic,strong)EditSignListViewModel *editVM;

@property(nonatomic,copy)NSString *feeStr;
@property(nonatomic,strong)NSMutableArray *baseNameArray; //左边基础必填项
@property(nonatomic,strong)NSMutableArray *leftMustArray; //左边名称
@property(nonatomic,strong)NSMutableArray *rightMustArray ; //右边名称
@property(nonatomic,strong)NSMutableArray *mustTypeArray ; // 左边inputType
@property(nonatomic,strong)NSMutableArray *requireArray ;

@end
@implementation NewPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self baseSetting];
    // Do any additional setup after loading the view.
}
#pragma mark --- baseSetting 基础设置 


- (void)baseSetting
{
    self.title = @"添加报名人员";
    [self rightButton];
     _editVM = [[EditSignListViewModel alloc]init];
    _personVM = [[NewPersonViewModel alloc]init];
    self.view.backgroundColor = ZDBackgroundColor;
    [self.view addSubview:self.tableView];
    NSArray *allOptionArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"optionArray%li",(long)self.activityID]];  //获取所有自定义项
    _baseNameArray = [[_personVM getBaseName:self.userInfo] mutableCopy];
    self.leftMustArray = [_editVM getMustArrayFromArray:_baseNameArray customArray:allOptionArray];
    //未填写和未填写*
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
    EditSignListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EditCellID"];
    if (!cell) {
        cell = [[EditSignListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EditCellID"];
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
    EditSignListTableViewCell *cell = (EditSignListTableViewCell *)textField.superview.superview;
    if ([_mustTypeArray[cell.tag] integerValue]==1) {
        [self.view endEditing:YES];
        [self pushToLabelEditWithIsMust:[_requireArray[cell.tag] boolValue] tag:cell.tag];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    EditSignListTableViewCell *cell = (EditSignListTableViewCell *)textField.superview.superview;
    if ([_requireArray[cell.tag] boolValue]) {  //textField必填 则textf 不能为空
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
            maskLabel *label = [[maskLabel alloc]initWithTitle:@"该输入框为必填项"];
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
    MoreLabelViewController *moreLabel = [[MoreLabelViewController alloc]init];
    moreLabel.isMust = isMust;
    moreLabel.textfTitle = _rightMustArray[tagIndex];  //传自带text
    [self.navigationController pushViewController:moreLabel animated:NO];
    moreLabel.strBlock = ^(NSString *str)  //回调值刷新界面
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

- (UIView *) createHeader  //创建头视图
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    view.backgroundColor=ZDBackgroundColor;
    return view;
}

- (UIView *) createFooter   //创建尾视图
{
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    view.backgroundColor=[UIColor clearColor];
    return view;
}


#pragma mark cell上视图创建
- (void)createViewWithCell :(EditSignListTableViewCell *)cell
{
        [self createLeftLabelWithStr:_leftMustArray[cell.tag] view:cell.contentView]; //创建左边label
        //  如果 inputType 为2 3 5 6 下拉框 多选框 单选框 日期控件 则创建右边label
        if ([_mustTypeArray[cell.tag] integerValue]==2||[_mustTypeArray[cell.tag] integerValue]==3||[_mustTypeArray[cell.tag] integerValue]==5||[_mustTypeArray[cell.tag] integerValue]==6) {
            [self createRightLabelWithStr:_rightMustArray[cell.tag] view:cell.contentView];
            //如果为0 1 7 文本数据 多文本数据 数字控件
        }else if ([_mustTypeArray[cell.tag] integerValue]==0||[_mustTypeArray[cell.tag] integerValue]==1||[_mustTypeArray[cell.tag] integerValue]==7)
        {
            [self createTextFieldWithStr:_rightMustArray[cell.tag] index:[_mustTypeArray[cell.tag] integerValue] view:cell.contentView];
        }else
        {
            [self createImageWithStr:_rightMustArray[cell.tag]  Cell:cell];
        }
  
}
- (void)createImageWithStr :(NSString *)str Cell :(EditSignListTableViewCell *)cell
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
- (void)createLeftLabelWithStr:(NSString *)Str view :(UIView *)view  //创建左边label
{
    UILabel *label = [MyLabel initWithLabelFrame:CGRectMake(10, 0, 80, 44) Text:Str textColor:[UIColor blackColor] font:KweixinFont(14) textAlignment:NSTextAlignmentLeft cornerRadius:0 masksToBounds:0];
    [view addSubview:label];
}
- (void)createRightLabelWithStr :(NSString *)str  view :(UIView *)view  //创建label
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
- (void)createTextFieldWithStr :(NSString *)str index :(NSInteger)index view :(UIView *)view //创建右边输入框
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
//        [textField setValue:[UIColor colorWithRed:137.0f/256.0f green:137.0f/256.0f blue:137.0f/256.0f alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
//        [textField setValue:KweixinFont(14) forKeyPath:@"_placeholderLabel.font"];
    }
    [view addSubview:textField];
}


#pragma mark label UITapGestureRecognizer 手势点击
- (void)gesAction:(UITapGestureRecognizer *)tap
{
    EditSignListTableViewCell *cell = (EditSignListTableViewCell *)tap.view.superview.superview;
    NSArray *allOptionArray = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"optionArray%li",(long)self.activityID]];  //获取所有自定义项
        switch ([_mustTypeArray[cell.tag] integerValue]) {
            case 2:
                //下拉
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:NO];
                break;
            case 3:
                //多选
            {
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:YES];
            }
                break;
            case 5:
                //单选
                [self pushMustChooseWithCell:cell customArray:allOptionArray isMoreChoose:NO];
                break;
            case 6:
                //日期
                [self showDataPicker:cell];
                break;
            default:
                break;
        }
}

- (void)pushMustChooseWithCell :(EditSignListTableViewCell *)cell customArray :(NSArray *)customArray isMoreChoose :(BOOL)isMoreChoose

//必填项 跳转至多选单选

{
    EditMoreChooseViewController *moreChoose = [[EditMoreChooseViewController alloc]init];
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

//必填项 选择图片
- (void)createImageViewWithCell1 :(EditSignListTableViewCell *)cell imageArray :(NSArray *)imageArray

{
    NSInteger x = 0 ;
    NSInteger y = 0 ;
    for (int i = 0; i < imageArray.count+1; i ++) {
        x = i / 3;  //x 为行
        y = i% 3 ;   // y 为列
        if (i < imageArray.count) {
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10+y*(kLineSpace+10), 54 + x *(kLineSpace+10), kLineSpace, kLineSpace) ];
            [imageview sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]];
            imageview.tag = i+100;
            imageview.userInteractionEnabled = YES;
            [cell.contentView addSubview:imageview];
            UIButton *deleteButton = [MyButton initWithButtonFrame:CGRectMake(kLineSpace-25, 0, 25, 25) title:nil textcolor:nil Target:self action:@selector(deleteImage:) BackgroundColor:nil cornerRadius:0 masksToBounds:0 ];
            [deleteButton setImage:[UIImage imageNamed:@"deleteCan"] forState:UIControlStateNormal];
            deleteButton.tag = i;
            [imageview addSubview:deleteButton];
        }else
        {
            UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+y*(kLineSpace+10), 54+x*(kLineSpace+10), kLineSpace, kLineSpace)] ;
            UIImageView *imageview = [[UIImageView alloc]initWithFrame: CGRectMake(kLineSpace/4, kLineSpace/4, kLineSpace/2, kLineSpace/2)];
            [addImageView addSubview:imageview];
            addImageView.layer.borderWidth = 0.5;
            addImageView.layer.borderColor = ZDPlaceHolderColor.CGColor;
            imageview.image = [UIImage imageNamed:@"加号"];
            [cell.contentView addSubview:addImageView];
            addImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageGes:)];
            [addImageView addGestureRecognizer:tap];
        }
    }
    
}
-(void) addImageGes :(UITapGestureRecognizer *)tap
{
    EditSignListTableViewCell *cell = (EditSignListTableViewCell *)tap.view.superview.superview;
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        if (image) {
            [NewOrEditMV changeToNetImage:image block:^(NSString *str) {
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
    EditSignListTableViewCell *cell = nil;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[EditSignListTableViewCell class]]) {
            cell = (EditSignListTableViewCell *)nextResponder;
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

- (void)showDataPicker:(EditSignListTableViewCell *)cell
{
    
        NSString *timeStr = _rightMustArray[cell.tag];
        if (timeStr.length<11) {
            timeStr = [timeStr stringByAppendingString:@" 00:00"];
        }else {}
        NSDate *date = [[Time alloc]getDateFromStr:timeStr];
        CCDatePickerView *DataView = [[CCDatePickerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithStr:@"日期选择" withDate:date];
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
                                 NSForegroundColorAttributeName : ZDGreenColor};
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
                MBProgressHUD *hud = [MyHud initWithMode:MBProgressHUDModeCustomView labelText:@"编辑成功" showAnimated:YES UIView:weakSelf.view imageName:@"签到打勾"];
                [hud hideAnimated:YES afterDelay:1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakBlock(1);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                });
            }
            else if (isSuccess==2)
            {
                maskLabel *label = [[maskLabel alloc]initWithTitle:@"请检查手机格式"];
                [label labelAnimationWithViewlong:weakSelf.view];
            }
            else
            {
                [[SignManager shareManager]showNotHaveNet:weakSelf.view];
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
