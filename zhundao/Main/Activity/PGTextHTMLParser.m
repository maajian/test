#import "PGTextHTMLParser.h"
#import "PGParagraphConfig.h"
#import "UIFont+LMText.m"
#import "NSTextAttachment+LMText.h"
@implementation PGTextHTMLParser
+ (NSString *)HTMLFromAttributedString:(NSAttributedString *)attributedString WithImageArray :(NSArray *)imageArray{
    NSInteger count = 0;
    BOOL isNewParagraph = YES;
    NSMutableString *htmlContent = [NSMutableString string];
    NSRange effectiveRange = NSMakeRange(0, 0);
    while (effectiveRange.location + effectiveRange.length < attributedString.length) {
        NSDictionary *attributes = [attributedString attributesAtIndex:effectiveRange.location effectiveRange:&effectiveRange];
        NSLog(@"dic = %@",attributes);
        NSTextAttachment *attachment = attributes[@"NSAttachment"];
        NSParagraphStyle *paragraph = attributes[@"NSParagraphStyle"];
        NSString *link  = attributes[@"NSLink"];
        PGParagraphConfig *paragraphConfig = [[PGParagraphConfig alloc] initWithParagraphStyle:paragraph type:LMParagraphTypeNone];
        if (attachment) {
            switch (attachment.attachmentType) {
                case LMTextAttachmentTypeImage:
                    if (attachment.userInfo==nil)
                    {
                        if (imageArray.count>count) {
                            NSString *urlString = imageArray[count];
                            attachment.userInfo = urlString;
                            count = count+1;
                        }
                    }
                [htmlContent appendString:[NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"/>", attachment.userInfo]];
                break;
                default:
                break;
            }
        }
        else if (link)
        {
            NSString *text = [[attributedString string] substringWithRange:effectiveRange];
            [htmlContent appendString:[NSString stringWithFormat:@"<a href=%@>%@</a>",link,text ]];
        }
        else {
            NSString *text = [[attributedString string] substringWithRange:effectiveRange];
            UIFont *font = attributes[NSFontAttributeName];
            UIColor *fontColor = attributes[@"NSColor"];
            NSString *color = [self PG_hexStringWithColor:fontColor];
            BOOL underline = [attributes[NSUnderlineStyleAttributeName] boolValue];
            BOOL isFirst = YES;
            NSArray *components = [text componentsSeparatedByString:@"\n"];
            for (NSInteger i = 0; i < components.count; i ++) {
                NSString *content = components[i];
                if (!isFirst && !isNewParagraph) {
                    [htmlContent appendString:@"</p>"];
                    isNewParagraph = YES;
                }
                if (isNewParagraph && (content.length > 0 || i < components.count - 1)) {
                    [htmlContent appendString:[NSString stringWithFormat:@"<p style=\"text-indent:%@em;margin:4px auto 0px auto;\">", @(2 * paragraphConfig.indentLevel).stringValue]];
                    isNewParagraph = NO;
                }
                [htmlContent appendString:[self PG_HTMLWithContent:content font:font underline:underline color:color]];
                isFirst = NO;
            }
            if (effectiveRange.location + effectiveRange.length >= attributedString.length && ![htmlContent hasSuffix:@"</p>"]) {
                [htmlContent appendString:@"</p>"];
            }
        }
        effectiveRange = NSMakeRange(effectiveRange.location + effectiveRange.length, 0);
    }
    return [htmlContent copy];
}
+ (NSString *)PG_HTMLWithContent:(NSString *)content font:(UIFont *)font underline:(BOOL)underline color:(NSString *)color {
    if (content.length == 0) {
        return @"";
    }
    if (font.bold) {
        content = [NSString stringWithFormat:@"<b>%@</b>", content];
    }
    if (font.italic) {
        content = [NSString stringWithFormat:@"<i>%@</i>", content];
    }
    if (underline) {
        content = [NSString stringWithFormat:@"<u>%@</u>", content];
    }
    return [NSString stringWithFormat:@"<font style=\"font-size:%f;color:%@\">%@</font>", font.fontSize, color, content];
}
+ (NSString *)PG_hexStringWithColor:(UIColor *)color {
    NSString *colorString = [[CIColor colorWithCGColor:color.CGColor] stringRepresentation];
    NSArray *parts = [colorString componentsSeparatedByString:@" "];
    NSMutableString *hexString = [NSMutableString stringWithString:@"#"];
    for (int i = 0; i < 3; i ++) {
        [hexString appendString:[NSString stringWithFormat:@"%02X", (int)([parts[i] floatValue] * 255)]];
    }
    return [hexString copy];
}
@end
