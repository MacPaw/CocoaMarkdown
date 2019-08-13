//
//  CMPlainTextTransformer.m
//  CocoaMarkdown
//
//  Created by Anton Barkov on 8/13/19.
//  Copyright © 2019 Indragie Karunaratne. All rights reserved.
//

#import "CMPlainTextTransformer.h"

@interface CMPlainTextTransformer()
@property (nonatomic, assign) CMPlainTextTransformerBlock block;
@property (nonatomic, assign) CMNodeType nodeType;
@property (nonatomic, assign) NSUInteger headerLevel;
@end

@implementation CMPlainTextTransformer

- (instancetype)initWithBlock:(CMPlainTextTransformerBlock)block
                     nodeType:(CMNodeType)nodeType
                  headerLevel:(NSUInteger)headerLevel
{
    self = [super init];
    if (self)
    {
        self.block = block;
        self.nodeType = nodeType;
        self.headerLevel = headerLevel;
    }
    return self;
}

@end
