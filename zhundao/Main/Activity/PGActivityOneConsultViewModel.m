#import "PGActivityOneConsultViewModel.h"
@implementation PGActivityOneConsultViewModel
- (void)postData:(NSInteger)ConsultID answer :(NSString *)answer IsRecommend:(BOOL)IsRecommend postBlock:(postBlock)postBlock {
    NSString *url = [[NSString stringWithFormat:@"%@api/PerBase/ReplyConsult/%li?accessKey=%@&answer=%@&IsRecommend=%@",zhundaoApi,(long)ConsultID,[[PGSignManager shareManager] getaccseekey],answer,IsRecommend?@"true":@"false"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ZD_NetWorkM postDataWithMethod:url parameters:nil succ:^(NSDictionary *obj) {
        NSLog(@" responseObject = %@ ",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if ([dic[@"Res"]integerValue ]==0) {
            postBlock(1);
        }else{
            postBlock(0);
        }
    } fail:^(NSError *error) {
        postBlock(0);
    }];
}
- (float)getHeight:(NSString *)str width :(float)width
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
    return size.height;
}
@end
