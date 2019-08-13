//
//  CMNodeKey.m
//  CocoaMarkdown
//
//  Created by Anton Barkov on 8/13/19.
//  Copyright © 2019 Indragie Karunaratne. All rights reserved.
//

#import "CMNodeKey.h"

@interface CMNodeKey()
@property (nonatomic, assign) CMNodeType nodeType;
@property (nonatomic, assign) NSUInteger headerLevel;
@end

@implementation CMNodeKey

- (instancetype)initWithNodeType:(CMNodeType)nodeType headerLevel:(NSUInteger)headerLevel
{
    self = [super init];
    if (self)
    {
        self.nodeType = nodeType;
        self.headerLevel = headerLevel;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return [[CMNodeKey alloc] initWithNodeType:self.nodeType headerLevel:self.headerLevel];
}

@end
