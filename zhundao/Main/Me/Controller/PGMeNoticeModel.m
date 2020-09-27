#import "PGMeNoticeModel.h"
@implementation PGMeNoticeModel
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.AddTime = [aDecoder decodeObjectForKey:@"AddTime"];
        self.Detail = [aDecoder decodeObjectForKey:@"Detail"];
        self.SortName = [aDecoder decodeObjectForKey:@"SortName"];
        self.Title = [aDecoder decodeObjectForKey:@"Title"];
        self.ID = [aDecoder decodeIntegerForKey:@"ID"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.AddTime forKey:@"AddTime"];
    [aCoder encodeObject:self.Detail forKey:@"Detail"];
    [aCoder encodeObject:self.SortName forKey:@"SortName"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeInteger:self.ID forKey:@"ID"];
}
@end
