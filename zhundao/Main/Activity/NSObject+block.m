#import "NSObject+block.h"
#import <objc/runtime.h>
@implementation NSObject (block)
- (ZDSuccessBlock)ZDSuccessBlock{
    return objc_getAssociatedObject(self, @selector(ZDSuccessBlock));
}
- (ZDErrorBlock)ZDErrorBlock{
    return objc_getAssociatedObject(self, @selector(ZDErrorBlock));
}
- (void)setZDErrorBlock:(ZDErrorBlock)ZDErrorBlock{
    objc_setAssociatedObject(self, @selector(ZDErrorBlock), ZDErrorBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setZDSuccessBlock:(ZDSuccessBlock)ZDSuccessBlock{
    objc_setAssociatedObject(self, @selector(ZDSuccessBlock), ZDSuccessBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
