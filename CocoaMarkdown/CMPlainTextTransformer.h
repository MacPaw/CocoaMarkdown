//
//  CMPlainTextTransformer.h
//  CocoaMarkdown
//
//  Created by Anton Barkov on 8/13/19.
//  Copyright © 2019 Indragie Karunaratne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMNode.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * _Nonnull (^CMPlainTextTransformerBlock)(NSString *string);

@interface CMPlainTextTransformer : NSObject
@property (nonatomic, assign, readonly) CMPlainTextTransformerBlock block;
@property (nonatomic, assign, readonly) CMNodeType nodeType;
@property (nonatomic, assign, readonly) NSUInteger headerLevel;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithBlock:(CMPlainTextTransformerBlock)block
                     nodeType:(CMNodeType)nodeType
                  headerLevel:(NSUInteger)headerLevel;
@end

NS_ASSUME_NONNULL_END
