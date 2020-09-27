#import "PGActivityMessageContentModel.h"
@implementation PGActivityMessageContentModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.ID = [dic[@"msg_id"] integerValue];
        self.es_content = dic[@"Msg_Info"] ? dic[@"Msg_Info"] : dic[@"es_content"];
        self.Reason = ZD_SafeValue(dic[@"Reason"]);
        if (dic[@"Status"]) {
            switch ([dic[@"Status"] integerValue]) {
                case 0:
                    self.messageStatusType = PGMessageStatusTypeCheck;
                    break;
                case 1:
                    self.messageStatusType = PGMessageStatusTypeSuccess;
                    break;
                case -1:
                    self.messageStatusType = PGMessageStatusTypeFail;
                    break;
                default:
                    break;
            }
        } else {
            self.messageStatusType = PGMessageStatusTypeSuccess;
        }
    }
    return self;
}
@end
