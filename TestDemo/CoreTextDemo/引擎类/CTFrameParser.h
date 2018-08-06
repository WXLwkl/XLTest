//
//  CTFrameParser.h
//  CoreTextDemo
//
//  Created by xingl on 16/4/20.
//  Copyright © 2016年 yinjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameParserConfig.h"

@interface CTFrameParser : NSObject

+ (NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;
+ (CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig*)config;
+ (CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig*)config;
+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig*)config;
@end
