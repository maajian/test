#import "PGNewOrEditMV.h"
@implementation PGNewOrEditMV
- (NSMutableAttributedString *)setAttrbriteStrWithText:(NSString *)text  
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:137.0f/256.0f green:137.0f/256.0f blue:137.0f/256.0f alpha:1] range:NSMakeRange(0, 3)];
    if ([text isEqualToString:@"必填项*"]||[text isEqualToString:@"未填写*"]) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:230.0f/256.0f green:67.0f/256.0f blue:64.0f/256.0f alpha:1] range:NSMakeRange(3, 1)];
    }
    [str addAttribute:NSFontAttributeName value:KweixinFont(14) range:NSMakeRange(0, text.length)];
    return  str;
}
- (void)setKeyboardTypeWithtextf :(UITextField *)TextField  
{
    switch (TextField.tag-100) {
        case 1:
            TextField.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
            break;
        case 8:
            TextField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        default:
            TextField.keyboardType = UIKeyboardTypeDefault;
            break;
    }
}
- (void)isNoDataTextField:(UITextField *)TextField
{
    NSString *str = [TextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSCharacterSet *set =  [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\'"];
    str = [str stringByTrimmingCharactersInSet:set];
    TextField.text = str;
}
+ (void)changeToNetImage :(UIImage *)image block:(upBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/OAuth/UploadFile",zhundaoH5Api];
    AFHTTPSessionManager *manager = [PGNetWorkManager shareHTTPSessionManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    [ZD_NetWorkM postDataWithMethod:urlStr parameters:nil constructing:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.8);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:data name:@"imgFile" fileName:fileName mimeType:@"image/jpeg"];
    } succ:^(NSDictionary *obj) {
        NSLog(@"responseObject = %@",obj);
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:obj];
        if (block) {
            block(dic[@"url"]);
        }
    } fail:^(NSError *error) {
    }];
}
- (NSMutableArray *)sexChangeWithArray :(NSArray *)dataArray  muArray :(NSMutableArray *)array
{
    if ([dataArray [3]integerValue]==0) {
        [array replaceObjectAtIndex:3 withObject:@"未知"];
    }else if ([dataArray [3]integerValue]==1)
    {
        [array replaceObjectAtIndex:3 withObject:@"男"];
    }else
    {
        [array replaceObjectAtIndex:3 withObject:@"女"];
    }
    return  array;
}
- (NSString *)sexChangeToStr :(NSString * )str
{
    if ([str isEqualToString:@"女"]) {
        return @"2";
    }
    else if ([str isEqualToString:@"男"])
    {
        return @"1";
    }else{
        return @"0";
    }
}
- (NSString *)searchContactGroupIDFromID:(NSInteger )ID
{
    PGSignManager *manager = [PGSignManager shareManager];
    NSString *str = nil;
    if ([manager.dataBase open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT ContactGroupID FROM contact WHERE ID = %li",(long)ID];
        FMResultSet *rs = [manager.dataBase executeQuery:sql];
        while ([rs next]) {
            str  = [NSString stringWithFormat:@"%li",(long)[rs intForColumn:@"ContactGroupID"]];
        }
        [manager.dataBase close];
    }
    return str;
}
@end
