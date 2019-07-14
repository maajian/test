//
//  ChooseViewController.m
//  zhundao
//
//  Created by zhundao on 2017/1/20.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "ChooseViewController.h"
#import "maskLabel.h"
@interface ChooseViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *_dataarray;
    UITextField *chooseTextField;
    UIImageView *_deleteImage;
    UIView *imageSelectView;
    UIView *zheview;
    NSMutableDictionary *textDic;
    UIView *footerView ;
    BOOL switchFlag;
}
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation ChooseViewController
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sureButton:(id)sender {
    NSInteger a =0;
    for (int i=0; i<textDic.count; i++) {
        NSString *value1 = [textDic objectForKey:[NSString stringWithFormat:@"%i",i]];
        for (int j=i+1; j<textDic.count; j++) {
            NSString *value2 = [textDic objectForKey:[NSString stringWithFormat:@"%i",j]];
            if ([value1 isEqualToString:value2]) {
                a = 1;
            }
        }
    }
    if (a==1) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"选项不能相同"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }
    else if ([_textView.text isEqualToString:@"请输入项目名称"]||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0||[[_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"输入框不能为空"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:2.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }
    else if (textDic.count!= _dataarray.count) {
        maskLabel *label = [[maskLabel alloc]initWithTitle:@"选项不能为空"];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(120, 35));
        }];
        [UIView animateWithDuration:1.5 animations:^{
            label.alpha =0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }
    else
    {
        
        [self sendData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.text = self.model.Title;
    _textView.delegate =self;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = NO;
    textDic =[NSMutableDictionary dictionary];
    [self setdic];
    [self getflag];
    [self getDataArray];
    [self setMianTitle];
    [_switch1 addTarget:self action:@selector(SwitchChange) forControlEvents:UIControlEventValueChanged];

    // Do any additional setup after loading the view from its nib.
}
- (void)setdic
{
    if (![_model.Option isEqual:[NSNull null] ]) {
        NSArray *array =[_model.Option componentsSeparatedByString:@"|"];
        for (int i=0; i<array.count; i++) {
            [textDic setObject:array[i] forKey:[NSString stringWithFormat:@"%i",i]];
        }
    }
}
- (void)setMianTitle
{
    NSUInteger type  = _model.InputType;
    switch (type) {
        case 2:
            _titleLabel.text = @"下拉框";
            break;
        case 3:
            _titleLabel.text = @"多选框";
            break;
        case 5:
            _titleLabel.text = @"单选框";
            break;
        default:
            break;
    }
}
-(void)getflag
{
    if (self.model.Required) {
        switchFlag = YES;
        [_switch1 setOn:YES];
    }
    else{
        switchFlag=NO;
        [_switch1 setOn:NO];
    }
}
- (void)getDataArray
{
    if (![_model.Option isEqual:[NSNull null] ]) {
        NSArray *array = [_model.Option componentsSeparatedByString:@"|"];
        NSMutableArray *Arr = [NSMutableArray array];
        for (int i =0; i<array.count; i++) {
            [Arr addObject:[NSString stringWithFormat:@"选项%i",i+1]];
        }
        _dataarray = [Arr copy];
    }
}
- (void)SwitchChange
{
    switchFlag = !switchFlag;
    NSLog(@"%i",switchFlag);
    if (switchFlag==NO) {
        [_switch1 setOn:NO];
    }
    else{
        [_switch1 setOn:YES];
    }
}
- (void)sendData
{
    NSMutableDictionary *sendDic = [NSMutableDictionary dictionary];
    [sendDic setObject:_textView.text forKey:@"Title"];
    [sendDic setValue:[NSString stringWithFormat:@"%li",(long)_model.InputType]  forKey:@"InputType"];
    NSMutableString *optionStr = [[NSMutableString alloc]init];
    [optionStr appendString:[textDic objectForKey:@"0"]];
    for (int i=1; i<textDic.count; i++) {
        [optionStr appendString:@"|"];
        [optionStr appendString:[textDic objectForKey:[NSString stringWithFormat:@"%d",i]]];
    }
    [sendDic setValue:[optionStr copy] forKey:@"Option"];
    if (switchFlag) {
        [sendDic setValue:@"true" forKey:@"Required"];
    }
    else{
        [sendDic setValue:@"false" forKey:@"Required"];
        
    }
    [sendDic setObject:[NSString stringWithFormat:@"%li",(long)_model.ID] forKey:@"ID"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[sendDic copy] options:0 error:nil];
    NSString *jsonStr = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSString *accesskey = [[SignManager shareManager]getaccseekey];
    NSString *posturl = [NSString stringWithFormat:@"%@api/PerActivity/UpdateOrAddOption?accessKey=%@",zhundaoApi,accesskey];
    
    [ZD_NetWorkM postDataWithMethod:posturl parameters:jsonStr succ:^(NSDictionary *obj) {
        NSLog(@"res = %@",obj);
        if (self.block) {
            self.block([sendDic copy]);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } fail:^(NSError *error) {
        
    }];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入项目名称"]) {
        textView.text = @"";
    }
    _textView.textColor = [UIColor blackColor];
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length<1) {
        textView.text = @"请输入项目名称";
        _textView.textColor = [UIColor lightGrayColor];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"chooseCell%li",(long)indexPath.row]];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"chooseCell%li",(long)indexPath.row]];
        
    }
    for (UIView *subView in cell.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UIView class]]) {
            [subView removeFromSuperview];
        }
    }
    zheview = [[UIView alloc]init];
    [cell addSubview:zheview];
    imageSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    imageSelectView.tag = indexPath.row;
    [cell addSubview:imageSelectView];
    chooseTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth-50, 44)];
    chooseTextField.tag = indexPath.row+100;
    chooseTextField.delegate = self;
    _deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 20, 20)];
    _deleteImage.contentMode = UIViewContentModeScaleAspectFill;
     [cell addSubview:chooseTextField];
    for (NSString *keyStr in textDic.allKeys) {
        if ([keyStr integerValue]==indexPath.row) {
            chooseTextField.text = [textDic objectForKey:keyStr];
        }
    }
    [imageSelectView addSubview:_deleteImage];
    chooseTextField.placeholder = _dataarray[indexPath.row];
    chooseTextField.font = [UIFont systemFontOfSize:14];
    if (_dataarray.count>2) {
        _deleteImage.image =  [UIImage imageNamed:@"deleteCan"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteView:)];
        imageSelectView.userInteractionEnabled = YES;
        
        [imageSelectView addGestureRecognizer:tap];
    }
    if (_dataarray.count<=2) {
        
        _deleteImage.image =  [UIImage imageNamed:@"deleteCant"];
        imageSelectView.userInteractionEnabled = NO;
    }
    
    zheview.backgroundColor = [UIColor colorWithRed:186.00f/255.00f green:187.00f/255.00f blue:192.00f/255.00f alpha:1];
    
    [zheview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.mas_bottom).with.offset(-1);
        make.right.equalTo(cell.mas_right).with.offset(0);
        make.height.mas_equalTo(@0.5);
        make.left.equalTo(cell.mas_left).with.offset(15);
    }];
    
    return cell;
}
- (void)deleteView:(UITapGestureRecognizer *)tap
{
    NSMutableArray *array = [_dataarray mutableCopy];
    NSInteger delete =0;
    if (textDic.count==0) {
        delete=0;
    }
    else
    {
        for (int i=0; i<textDic.count; i++)  {
            NSString *keyStr = textDic.allKeys[i];
            if ([keyStr integerValue] ==tap.view.tag) {
                [array removeLastObject];
                [textDic removeObjectForKey:keyStr];
                delete=1;
            }
            
        }
    }
    if (delete==0) {
        [array removeLastObject];
    }
    NSMutableArray *arr = [textDic.allKeys mutableCopy];
    for (int i=0; i<arr.count; i++) {
        for (int j=i+1; j<arr.count; j++) {
            if ([arr[i] integerValue]>[arr[j] integerValue]) {
                NSInteger a,b,temp;
                a = [arr[i] integerValue];
                b= [arr[j] integerValue];
                
                
                
                
                temp =a;
                a = b;
                b= temp;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%li",(long)a]];
                [arr replaceObjectAtIndex:j withObject:[NSString stringWithFormat:@"%li",(long)b]];
                NSLog(@"arr =%@",arr);
            }
        }
    }
    for (int i=0; i<arr.count; i++)  {
        NSInteger a = [arr[i] integerValue];
        if (a>tap.view.tag) {
            NSString *valuestr = [textDic valueForKey:arr[i]];
            [textDic removeObjectForKey:arr[i]];
            [textDic setObject:valuestr forKey:[NSString stringWithFormat:@"%li",(long)a-1]];
        }
    }
    _dataarray = [array copy];
    [_tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_dataarray.count inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [_tableview reloadData];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger a = (long)textField.tag-100;
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length!=0) {
        [textDic setObject:textField.text forKey:[NSString stringWithFormat:@"%li",(long)a]];
    }
    else
    {
        textField.text = @"";
        if ([textDic objectForKey:[NSString stringWithFormat:@"%li",(long)a]]!=nil) {
            [textDic removeObjectForKey:[NSString stringWithFormat:@"%li",(long)a]];
        }
        
    }
    footerView.hidden = NO;
    //      NSLog(@"dic = %@",textDic);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"view = %f",footerView.frame.origin.y);
    [UIView animateWithDuration:3 animations:^{
        footerView.hidden = YES;
    } completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12, 20, 20)];
    [footerView addSubview:imageview];
    
    imageview.image = [UIImage imageNamed:@"addChoose"];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth-50, 44)];
    label.text = @"增加选项";
    label.textAlignment =NSTextAlignmentLeft;
    [footerView addSubview:label];
    label.font = [UIFont systemFontOfSize:14];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 44, kScreenWidth-50, 16)];
    label1.text = @"修改可能会对已发布活动造成影响";
    label1.textAlignment =NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor colorWithRed:136.00/255.00 green:136.00/255.00 blue:136.00/255.00 alpha:1];
    [footerView addSubview:label1];
    
    footerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap)];
    [footerView addGestureRecognizer:tap];
    return footerView;
    
    
}
- (void)viewTap
{
    NSMutableArray *array = [_dataarray mutableCopy];
    [array addObject:[NSString stringWithFormat:@"选项%li",(unsigned long)_dataarray.count+1]];
    _dataarray = [array copy];
    if (_dataarray.count) {
        [_tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:array.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableview reloadData];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 75;
}

@end
