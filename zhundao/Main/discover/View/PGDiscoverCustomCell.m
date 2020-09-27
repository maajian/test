#import "PGDiscoverCustomCell.h"
@implementation PGDiscoverCustomCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(PGDiscoverCustomModel *)model
{
    if (model!= nil) {
        _model =model;
        _nameLabel.text = _model.Title;
                    if (model.InputType==0) {
                        _typeLabel.text = @"【输入框】";
                    }
                    else if (model.InputType==1)
                                 {
                                     _typeLabel.text = @"【多文本】";
                                 }
                    else if (model.InputType==2)
                    {
                         _typeLabel.text = @"【下拉框】";
                    }
                    else if (model.InputType==3)
                    {
                        _typeLabel.text = @"【多选框】";
                    }
                    else if(model.InputType==4){
                        _typeLabel.text = @"【图  片】";
                    }
                    else if(model.InputType==5){
                        _typeLabel.text = @"【单  选】";
                    }
                    else if(model.InputType==6){
                        _typeLabel.text = @"【日  期】";
                    }
        else
        {
             _typeLabel.text = @"【数  字】";
        }
                    if (model.Required==0) {
                        _markLabel.textColor = [UIColor lightGrayColor];
                    }
                    else
                    {
                        _markLabel.textColor = [UIColor redColor];
                    }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
