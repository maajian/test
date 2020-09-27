#import "PGTrainParticularModel.h"
#import "PGDiscoverShakeTableViewDelegateObj.h"
#import "PGDiscoverDetailShakeVC.h"
#import "PGDiscoverDetailModel.h"
#import "Time.h"
@interface PGDiscoverShakeTableViewDelegateObj ()
{
    UITableViewCell *mycell;
}
@end
@implementation PGDiscoverShakeTableViewDelegateObj
+(instancetype)createTableViewDelegateWithDataList:(PGDiscoverDetailModel *)model   withdic :(NSDictionary *)dic
{
    return  [[[self class]alloc]initTableViewDelegateWithDataList:model  withdic :dic ];
}
- (instancetype)initTableViewDelegateWithDataList:(PGDiscoverDetailModel *)model   withdic :(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.model = model;
        self.datadic = dic;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = @[@"图标",
                       @"标题",
                       @"设备ID",
                       @"购买时间",
                       @"绑定功能"];
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier1"];
        }
        for (UIView *subview in cell.subviews) {
            NSLog(@"view = %@",cell.subviews);
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIImageView class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIView class]]) {
                [subview removeFromSuperview];
            }
        }
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = ZDGrayColor;
        [cell addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(0);
            make.right.equalTo(cell).offset(0);
        }];
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = ZDGrayColor;
        [cell addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(10);
            make.right.equalTo(cell).offset(0);
        }];
        UIImageView *iconImageview = [[UIImageView alloc]init];
        [cell addSubview: iconImageview];
        [iconImageview mas_makeConstraints:^(MASConstraintMaker *make) {
              make.top.equalTo(cell).offset(12);
            make.right.equalTo(cell).offset(-10);
            make.height.equalTo(@66);
            make.width.equalTo(@66);
        }];
        iconImageview.layer.cornerRadius = 4;
        iconImageview.layer.masksToBounds =YES;
        [iconImageview sd_setImageWithURL:[NSURL URLWithString:_model.IconUrl]];
        UILabel  *_baseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _baseLabel.font = [UIFont systemFontOfSize:14];
        _baseLabel.textColor = [UIColor blackColor];
        [cell addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.left.mas_equalTo(cell).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
        }];
        _baseLabel.text = array[indexPath.row];
        return cell;
    }
    else if (indexPath.row==1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier2"];
        }
        for (UIView *subview in cell.subviews) {
            NSLog(@"view = %@",cell.subviews);
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIView class]]) {
                [subview removeFromSuperview];
            }
        }
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = ZDGrayColor;
        [cell addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(10);
            make.right.equalTo(cell).offset(0);
        }];
        UILabel  *_baseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _baseLabel.font = [UIFont systemFontOfSize:14];
        _baseLabel.textColor = [UIColor blackColor];
        [cell addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
             make.height.equalTo(@30);
            make.left.mas_equalTo(cell).offset(10);
            make.width.equalTo(@80);
        }];
        _baseLabel.text = array[indexPath.row];
        UILabel *nameLabel = [[UILabel alloc]init];
        [cell addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
             make.height.equalTo(@30);
            make.right.equalTo(cell).offset(-10);
            make.left.equalTo(_baseLabel).offset(5);
        }];
                nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = _model.Title;
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.textColor = [UIColor lightGrayColor];
        return cell;
    }
    else if (indexPath.row==2)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier2"];
        }
        for (UIView *subview in cell.subviews) {
            NSLog(@"view = %@",cell.subviews);
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIView class]]) {
                [subview removeFromSuperview];
            }
        }
        UIView *view1 = [[UIView alloc]init];
        [cell addSubview:view1];
         view1.backgroundColor =ZDGrayColor;
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(10);
            make.right.equalTo(cell).offset(0);
        }];
        UILabel  *_baseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _baseLabel.font = [UIFont systemFontOfSize:14];
        _baseLabel.textColor = [UIColor blackColor];
        [cell addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.left.mas_equalTo(cell).offset(10);
            make.width.equalTo(@80);
             make.height.equalTo(@30);
        }];
        _baseLabel.text = array[indexPath.row];
        UILabel *nameLabel = [[UILabel alloc]init];
        [cell addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.right.equalTo(cell).offset(-10);
            make.left.equalTo(_baseLabel).offset(5);
             make.height.equalTo(@30);
        }];
                nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = _model.DeviceId;
        nameLabel.textAlignment = NSTextAlignmentRight;
      nameLabel.textColor = [UIColor lightGrayColor];
        return cell;
    }
    else if (indexPath.row==3)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier2"];
        }
        for (UIView *subview in cell.subviews) {
            NSLog(@"view = %@",cell.subviews);
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIView class]]) {
                [subview removeFromSuperview];
            }
        }
        UILabel  *_baseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _baseLabel.font = [UIFont systemFontOfSize:14];
        _baseLabel.textColor = [UIColor blackColor];
        [cell addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.left.mas_equalTo(cell).offset(10);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
        _baseLabel.text = array[indexPath.row];
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor =ZDGrayColor;
        [cell addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(10);
            make.right.equalTo(cell).offset(0);
        }];
        UILabel *nameLabel = [[UILabel alloc]init];
        [cell addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.right.equalTo(cell).offset(-10);
            make.left.equalTo(_baseLabel).offset(5);
            make.height.equalTo(@30);
        }];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = [[Time alloc]leftYearStrWithStr:_model.BindTime];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.textColor = [UIColor lightGrayColor];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier2"];
        }
        for (UIView *subview in cell.subviews) {
            NSLog(@"view = %@",cell.subviews);
            if ([subview isKindOfClass:[UILabel class]]) {
                [subview removeFromSuperview];
            }
            if ([subview isKindOfClass:[UIView class]]) {
                [subview removeFromSuperview];
            }
        }
        UILabel  *_baseLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _baseLabel.font = [UIFont systemFontOfSize:14];
        _baseLabel.textColor = [UIColor blackColor];
        [cell addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.left.mas_equalTo(cell).offset(10);
            make.width.equalTo(@80);
             make.height.equalTo(@30);
        }];
        _baseLabel.text = array[indexPath.row];
        UIView *view1 = [[UIView alloc]init];
         view1.backgroundColor =ZDGrayColor;
        [cell addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.height.equalTo(@0.5);
            make.left.equalTo(cell).offset(0);
            make.right.equalTo(cell).offset(0);
        }];
        UILabel *nameLabel = [[UILabel alloc]init];
        [cell addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell);
            make.right.equalTo(cell).offset(-30);
            make.left.equalTo(_baseLabel).offset(5);
             make.height.equalTo(@30);
        }];
        if (_model.NickName) {
            nameLabel.text = _model.NickName;
        }
        else
        {
            nameLabel.text = @"未绑定";
        }
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.textColor = [UIColor lightGrayColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row==4&&indexPath.section==0) {
        [_detailModelDelegate selectIndex:indexPath];
        mycell= [tableView cellForRowAtIndexPath:indexPath];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 90;
    }
    else{
          return 40;
    }
}
@end
